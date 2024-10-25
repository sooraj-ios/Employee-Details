//
//  APIsList.swift
//  Employee Details
//
//  Created by Sooraj R on 25/10/24.
//

import Foundation

final class APIsList {

    static let shared = APIsList()

    //Base URL
    let baseUrl = "https://test.pixbit.in/api"

    //End Points
    let login = "/login"
    let register = "/register"
    let employees = "/employees?page="
    let addEmployee = "/employees"
    let employeeDetails = "/employees/"
    let designation = "/designations"
    let addDesignation = "/designations"
}
