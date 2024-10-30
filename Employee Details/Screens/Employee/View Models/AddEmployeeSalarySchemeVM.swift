//
//  AddEmployeeSalarySchemeVM.swift
//  Employee Details
//
//  Created by Sooraj R on 30/10/24.
//

import Foundation
class AddEmployeeSalarySchemeVM {
    var isLoadingData: Observable<Bool> = Observable(false)
    var showError: Observable<String> = Observable(nil)
    var added: Observable<Bool> = Observable(false)

    func addEmployee(parameters:[[String: Any]]){
        if isLoadingData.value ?? true { return }
        isLoadingData.value = true
        APICallManager.shared.performMultipartAPIRequest(method: .POST, apiURL: APIsList.shared.baseUrl + APIsList.shared.addEmployee, parameters: parameters, responseType: EmployeeCreatedModel.self) { [weak self] result in
            self?.isLoadingData.value = false
            switch result {
            case .success(let model):
                if let error = model.message{
                    self?.showError.value = error
                }else{
                    self?.added.value = true
                }
            case .failure(let error):
                print(error.localizedDescription)
                self?.showError.value = error.localizedDescription
            }
        }
    }
}
