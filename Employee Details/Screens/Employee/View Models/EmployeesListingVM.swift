//
//  EmployeesListingVM.swift
//  Employee Details
//
//  Created by Sooraj R on 25/10/24.
//

import Foundation
class EmployeesListingVM {
    var isLoadingData: Observable<Bool> = Observable(false)
    var showError: Observable<String> = Observable(nil)
    var employees: Observable<EmployeeModel> = Observable(nil)
    
    func getEmployees(page:Int){
        if isLoadingData.value ?? true { return }
        isLoadingData.value = true
        APICallManager.shared.performAPIRequest(method: .GET, apiURL: APIsList.shared.baseUrl + APIsList.shared.employees, parameters: [], headers: ["Authorization":"Bearer \(AppUserData.shared.token)"], responseType: EmployeeModel.self) { [weak self] result in
            self?.isLoadingData.value = false
            switch result {
            case .success(let model):
                if let error = model.error{
                    print(error)
                    self?.showError.value = error
                }else{
                    self?.employees.value = model
                }
            case .failure(let error):
                print(error.localizedDescription)
                self?.showError.value = error.localizedDescription
            }
        }
    }
}
