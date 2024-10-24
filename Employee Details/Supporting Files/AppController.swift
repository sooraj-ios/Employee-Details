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
}

class AppController {
    static let shared = AppController()

    var login: LoginVC {
        AppStoryboard.shared.authentication.instantiateViewController(identifier: "LoginVC_id") as! LoginVC
    }

    var register: RegisterVC {
        AppStoryboard.shared.authentication.instantiateViewController(identifier: "RegisterVC_id") as! RegisterVC
    }
}
