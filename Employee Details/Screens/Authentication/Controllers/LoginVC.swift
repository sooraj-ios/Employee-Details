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
    @IBOutlet weak var signinButton: PrimaryButton!
    @IBOutlet weak var passwordHideShowIconView: UIImageView!
    
    // MARK: - LOADING VIEW CONTROLLER
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    func configureView(){
        signinButton.setAsDisabled()
        emailField.addTarget(self, action: #selector(typing(_ :)), for: .editingChanged)
        passwordField.addTarget(self, action: #selector(typing(_ :)), for: .editingChanged)
    }

    // MARK: - BUTTON ACTIONS
    @IBAction func passwordHideShowButtonAction(_ sender: UIButton) {
        passwordField.isSecureTextEntry = !passwordField.isSecureTextEntry
        passwordHideShowIconView.image = UIImage(named: passwordField.isSecureTextEntry ? "password_hidden_icon" : "password_shown_icon")
    }

    @IBAction func signinButtonAction(_ sender: UIButton) {
        let nextVC = AppController.shared.employeesListing
        self.navigationController?.pushViewController(nextVC, animated: true)
    }

    @IBAction func registerButtonAction(_ sender: UIButton) {
        let nextVC = AppController.shared.register
        self.navigationController?.pushViewController(nextVC, animated: true)
    }

    // MARK: - FUNCTIONS
    @objc func typing(_ sender: UITextField){
        checkValidations()
    }
    func checkValidations(){
        _ = emailField.text ?? "" != "" && passwordField.text ?? "" != "" ? signinButton.setAsEnabled() : signinButton.setAsDisabled()
    }
}

