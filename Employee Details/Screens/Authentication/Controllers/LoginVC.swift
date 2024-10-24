//
//  LoginVC.swift
//  Employee Details
//
//  Created by Sooraj R on 24/10/24.
//

import UIKit

class LoginVC: UIViewController {
    // MARK: - IBOUTLETS
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signinButton: UIButton!
    @IBOutlet weak var passwordHideShowIconView: UIImageView!
    
    // MARK: - LOADING VIEW CONTROLLER
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - BUTTON ACTIONS
    @IBAction func passwordHideShowButtonAction(_ sender: UIButton) {
        passwordField.isSecureTextEntry = !passwordField.isSecureTextEntry
        passwordHideShowIconView.image = UIImage(named: passwordField.isSecureTextEntry ? "password_hidden_icon" : "password_shown_icon")
    }

    @IBAction func signinButtonAction(_ sender: UIButton) {
    }

    @IBAction func registerButtonAction(_ sender: UIButton) {
        let nextVC = AppController.shared.register
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

