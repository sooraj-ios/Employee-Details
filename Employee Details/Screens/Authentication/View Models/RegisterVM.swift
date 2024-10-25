//
//  RegisterVM.swift
//  Employee Details
//
//  Created by Sooraj R on 25/10/24.
//

import Foundation
class RegisterVM {
    var isLoadingData: Observable<Bool> = Observable(false)
    var showError: Observable<String> = Observable(nil)
    var token: Observable<String> = Observable(nil)

    func register(name:String, email:String, password:String, confirmPassword:String){
        let parameters = [
            [
                "key": "name",
                "value": name,
                "type": "text"
            ],
            [
                "key": "email",
                "value": email,
                "type": "text"
            ],
            [
                "key": "password",
                "value": password,
                "type": "text"
            ],
            [
                "key": "confirm_password",
                "value": confirmPassword,
                "type": "text"
            ]] as [[String: Any]]
        if isLoadingData.value ?? true { return }
        isLoadingData.value = true
        APICallManager.shared.performAPIRequest(method: .POST, apiURL: APIsList.shared.baseUrl + APIsList.shared.register, parameters: parameters, responseType: RegisterModel.self) { [weak self] result in
            self?.isLoadingData.value = false
            switch result {
            case .success(let model):
                if let error = model.email{
                    print(error)
                    self?.showError.value = error.first ?? "There is an issue with your email"
                }else if let error = model.password{
                    print(error)
                    self?.showError.value = error.first ?? "There is an issue with your password"
                }else if let error = model.confirm_password{
                    print(error)
                    self?.showError.value = error.first ?? "There is an issue with your confirm password"
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
