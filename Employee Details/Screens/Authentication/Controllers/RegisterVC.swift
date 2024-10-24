//
//  RegisterVC.swift
//  Employee Details
//
//  Created by Sooraj R on 24/10/24.
//

import UIKit

class RegisterVC: UIViewController {
    // MARK: - IBOUTLETS
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var passwordHideShowIconView: UIImageView!
    @IBOutlet weak var confirmPasswordHideShowIconView: UIImageView!

    // MARK: - LOADING VIEW CONTROLLER
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    func configureView(){
        passwordField.textContentType = .oneTimeCode
        confirmPasswordField.textContentType = .oneTimeCode
    }

    // MARK: - BUTTON ACTIONS
     @IBAction func backAction(_ sender: UIButton) {
         self.navigationController?.popViewController(animated: true)
     }

    @IBAction func passwordHideShowButtonAction(_ sender: UIButton) {
        passwordField.isSecureTextEntry = !passwordField.isSecureTextEntry
        passwordHideShowIconView.image = UIImage(named: passwordField.isSecureTextEntry ? "password_hidden_icon" : "password_shown_icon")
    }

    @IBAction func confirmPasswordHideShowButtonAction(_ sender: UIButton) {
        confirmPasswordField.isSecureTextEntry = !confirmPasswordField.isSecureTextEntry
        confirmPasswordHideShowIconView.image = UIImage(named: confirmPasswordField.isSecureTextEntry ? "password_hidden_icon" : "password_shown_icon")
    }
}
