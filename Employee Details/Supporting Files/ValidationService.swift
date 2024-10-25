//
//  ValidationService.swift
//  Employee Details
//
//  Created by Sooraj R on 25/10/24.
//

import UIKit

enum ValidationError: Error {

    //MARK: - Email
    case emptyMail
    case invalidMail
}

extension ValidationError: LocalizedError {
    var errorDescription: String? {
        switch self {
        //MARK: - Email
        case .emptyMail:
            return "Please enter email field."
        case .invalidMail:
            return "Please enter a valid email address."
        }
    }
}

struct ValidationService {

    //MARK: - Email
    static func validate(email: String?) throws -> String {
        guard let email = email, !email.isEmpty else {
            throw ValidationError.emptyMail
        }
        guard email.isValidEmail() else{
            throw ValidationError.invalidMail
        }
        return email
    }

}
