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
    var token: Observable<String> = Observable(nil)

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
        APICallManager.shared.performAPIRequest(method: .POST, apiURL: APIsList.shared.baseUrl + APIsList.shared.login, parameters: parameters, responseType: LoginModel.self) { [weak self] result in
            self?.isLoadingData.value = false
            switch result {
            case .success(let model):
                if let error = model.error{
                    print(error)
                    self?.showError.value = error
                }else{
                    self?.token.value = model.access_token
                }
            case .failure(let error):
                print(error.localizedDescription)
                self?.showError.value = error.localizedDescription
            }
        }
    }
}
