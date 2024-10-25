//
//  AppUserData.swift
//  Employee Details
//
//  Created by Sooraj R on 25/10/24.
//

import Foundation
class AppUserData {

    static let shared = AppUserData()

    private let userDefaults = UserDefaults.standard

    var token: String {
        get {
            return userDefaults.string(forKey: "token") ?? ""
        }
        set(data) {
            userDefaults.set(data, forKey: "token")
        }
    }
}
