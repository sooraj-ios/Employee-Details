//
//  APICallManager.swift
//  Employee Details
//
//  Created by Sooraj R on 24/10/24.
//

import Foundation

enum HTTPMethod: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
}

class APICallManager {

    static let shared = APICallManager()

    func performAPIRequest<T: Decodable>(method: HTTPMethod, apiURL: String, parameters: [[String: Any]]? = nil, headers: [String: String]? = nil, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: apiURL) else {
            let urlError = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
            completion(.failure(urlError))
            return
        }

        var request = URLRequest(url: url, timeoutInterval: Double.infinity)
        request.httpMethod = method.rawValue

        if let headers = headers {
            for (key, value) in headers {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }

        if method == .POST || method == .PUT {
            let boundary = "Boundary-\(UUID().uuidString)"
            request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

            if let parameters = parameters {
                var body = Data()
                for param in parameters {
                    guard let paramName = param["key"] as? String else { continue }
                    body.append("--\(boundary)\r\n".data(using: .utf8)!)
                    body.append("Content-Disposition:form-data; name=\"\(paramName)\"".data(using: .utf8)!)

                    if let paramType = param["type"] as? String, paramType == "text", let paramValue = param["value"] as? String {
                        body.append("\r\n\r\n\(paramValue)\r\n".data(using: .utf8)!)
                    } else if let paramSrc = param["src"] as? String, let fileURL = URL(string: paramSrc), let fileContent = try? Data(contentsOf: fileURL) {
                        let filename = paramSrc.split(separator: "/").last ?? "file"
                        body.append("; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
                        body.append("Content-Type: \"application/octet-stream\"\r\n\r\n".data(using: .utf8)!)
                        body.append(fileContent)
                        body.append("\r\n".data(using: .utf8)!)
                    }
                }
                body.append("--\(boundary)--\r\n".data(using: .utf8)!)
                request.httpBody = body
            }
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                let noDataError = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                completion(.failure(noDataError))
                return
            }

            do {
                let decodedResponse = try JSONDecoder().decode(responseType, from: data)
                completion(.success(decodedResponse))
            } catch let decodingError {
                completion(.failure(decodingError))
            }
        }
        task.resume()
    }
}