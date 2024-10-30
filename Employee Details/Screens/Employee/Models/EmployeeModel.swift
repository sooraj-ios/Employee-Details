//
//  EmployeeModel.swift
//  Employee Details
//
//  Created by Sooraj R on 25/10/24.
//

import Foundation
struct EmployeeModel: Codable{
    var data:[Employee]?
    var error: String?
}

struct Employee : Codable {
    let id : Int?
    let user_id : Int?
    let first_name : String?
    let last_name : String?
    let profile_image_url : String?
    let resume : String?
    let date_of_birth : String?
    let gender : String?
    let email : String?
    let designation : String?
    let mobile_number : String?
    let address : String?
    let contract_period : Int?
    let total_salary : Int?
    let monthly_payments : [Monthly_payments]?
    let created_at : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case user_id = "user_id"
        case first_name = "first_name"
        case last_name = "last_name"
        case profile_image_url = "profile_image_url"
        case resume = "resume"
        case date_of_birth = "date_of_birth"
        case gender = "gender"
        case email = "email"
        case designation = "designation"
        case mobile_number = "mobile_number"
        case address = "address"
        case contract_period = "contract_period"
        case total_salary = "total_salary"
        case monthly_payments = "monthly_payments"
        case created_at = "created_at"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        user_id = try values.decodeIfPresent(Int.self, forKey: .user_id)
        first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
        last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
        profile_image_url = try values.decodeIfPresent(String.self, forKey: .profile_image_url)
        resume = try values.decodeIfPresent(String.self, forKey: .resume)
        date_of_birth = try values.decodeIfPresent(String.self, forKey: .date_of_birth)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        designation = try values.decodeIfPresent(String.self, forKey: .designation)
        mobile_number = try values.decodeIfPresent(String.self, forKey: .mobile_number)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        contract_period = try values.decodeIfPresent(Int.self, forKey: .contract_period)
        total_salary = try values.decodeIfPresent(Int.self, forKey: .total_salary)
        monthly_payments = try values.decodeIfPresent([Monthly_payments].self, forKey: .monthly_payments)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
    }

}


struct Monthly_payments : Codable {
    let id : Int?
    let payment_date : String?
    let amount : Int?
    let amount_percentage : Int?
    let remarks : String?
    let created_at : String?
}
