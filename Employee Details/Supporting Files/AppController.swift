//
//  AppController.swift
//  Employee Details
//
//  Created by Sooraj R on 24/10/24.
//

import UIKit

class AppStoryboard {
    static let shared = AppStoryboard()

    var authentication:UIStoryboard {
        UIStoryboard(name: "Authentication", bundle: nil)
    }

    var employee:UIStoryboard {
        UIStoryboard(name: "Employee", bundle: nil)
    }
}

class AppController {
    static let shared = AppController()

    // Authentication screens
    var login: LoginVC {
        AppStoryboard.shared.authentication.instantiateViewController(identifier: "LoginVC_id") as! LoginVC
    }

    var register: RegisterVC {
        AppStoryboard.shared.authentication.instantiateViewController(identifier: "RegisterVC_id") as! RegisterVC
    }

    // Employee screens
    var employeesListing: EmployeesListingVC {
        AppStoryboard.shared.employee.instantiateViewController(identifier: "EmployeesListingVC_id") as! EmployeesListingVC
    }

    var employeeDetails: EmployeeDetailsVC {
        AppStoryboard.shared.employee.instantiateViewController(identifier: "EmployeeDetailsVC_id") as! EmployeeDetailsVC
    }

    var addEmployeeBasicDetails: AddEmployeeBasicDetailsVC {
        AppStoryboard.shared.employee.instantiateViewController(identifier: "AddEmployeeBasicDetailsVC_id") as! AddEmployeeBasicDetailsVC
    }

    var addEmployeeContactDetails: AddEmployeeContactDetailsVC {
        AppStoryboard.shared.employee.instantiateViewController(identifier: "AddEmployeeContactDetailsVC_id") as! AddEmployeeContactDetailsVC
    }

    var addEmployeeSalaryScheme: AddEmployeeSalarySchemeVC {
        AppStoryboard.shared.employee.instantiateViewController(identifier: "AddEmployeeSalarySchemeVC_id") as! AddEmployeeSalarySchemeVC
    }

    var addPayment: AddPaymentVC {
        AppStoryboard.shared.employee.instantiateViewController(identifier: "AddPaymentVC_id") as! AddPaymentVC
    }
}
