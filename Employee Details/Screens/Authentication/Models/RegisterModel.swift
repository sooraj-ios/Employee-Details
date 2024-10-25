//
//  RegisterModel.swift
//  Employee Details
//
//  Created by Sooraj R on 25/10/24.
//

import Foundation

struct RegisterModel: Codable{
    var access_token: String?
    var email: [String]?
    var password: [String]?
    var confirm_password: [String]?
}
