//
//  LoginVM.swift
//  Employee Details
//
//  Created by Sooraj R on 25/10/24.
//

import Foundation
class LoginVM {
    var isLoadingData: Observable<Bool> = Observable(false)
    var showError: Observable<String> = Observable(nil)

    func signIn(email:String, password:String){
        let parameters = [
          [
            "key": "email",
            "value": email,
            "type": "text"
          ],
          [
            "key": "password",
            "value": password,
            "type": "text"
          ]] as [[String: Any]]
        if isLoadingData.value ?? true { return }
        isLoadingData.value = true
        APICallManager.shared.performAPIRequest(method: .POST, apiURL: "", parameters: [], responseType: String.self) { [weak self] result in
            self?.isLoadingData.value = false
            switch result {
            case .success(let model):
                print("Success: \(model)")
            case .failure(let error):
                self?.showError.value = error.localizedDescription
            }
        }
    }
}
