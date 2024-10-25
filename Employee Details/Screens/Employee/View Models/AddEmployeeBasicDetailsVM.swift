//
//  AddEmployeeBasicDetailsVM.swift
//  Employee Details
//
//  Created by Sooraj R on 25/10/24.
//

import Foundation
class AddEmployeeBasicDetailsVM {
    var isLoadingData: Observable<Bool> = Observable(false)
    var showError: Observable<String> = Observable(nil)
    var designations: Observable<[DesignationModel]> = Observable(nil)

    func getDesignations(){
        if isLoadingData.value ?? true { return }
        isLoadingData.value = true
        APICallManager.shared.performAPIRequest(method: .GET, apiURL: APIsList.shared.baseUrl + APIsList.shared.designation, parameters: [], headers: ["Authorization":"Bearer \(AppUserData.shared.token)"], responseType: [DesignationModel].self) { [weak self] result in
            self?.isLoadingData.value = false
            switch result {
            case .success(let model):
                self?.designations.value = model
            case .failure(let error):
                print(error.localizedDescription)
                self?.showError.value = error.localizedDescription
            }
        }
    }
}
