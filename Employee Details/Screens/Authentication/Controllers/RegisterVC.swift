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
    @IBOutlet weak var registerButton: PrimaryButton!
    @IBOutlet weak var passwordHideShowIconView: UIImageView!
    @IBOutlet weak var confirmPasswordHideShowIconView: UIImageView!

    // MARK: - VARIABLES AND CONSTANTS
    var viewModel: RegisterVM = RegisterVM()
    let activityIndicator = ActivityIndicator()

    // MARK: - LOADING VIEW CONTROLLER
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        bindViewModel()
    }

    func configureView(){
        registerButton.setAsDisabled()
        passwordField.textContentType = .oneTimeCode
        confirmPasswordField.textContentType = .oneTimeCode
        nameField.addTarget(self, action: #selector(typing(_ :)), for: .editingChanged)
        emailField.addTarget(self, action: #selector(typing(_ :)), for: .editingChanged)
        passwordField.addTarget(self, action: #selector(typing(_ :)), for: .editingChanged)
        confirmPasswordField.addTarget(self, action: #selector(typing(_ :)), for: .editingChanged)
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

    @IBAction func registerButtonAction(_ sender: UIButton) {
        viewModel.register(name: nameField.text ?? "", email: emailField.text ?? "", password: passwordField.text ?? "", confirmPassword: confirmPasswordField.text ?? "")
    }

    // MARK: - FUNCTIONS
    @objc func typing(_ sender: UITextField){
        checkValidations()
    }

    func checkValidations(){
        _ = (emailField.text ?? "").isValidEmail() && (passwordField.text ?? "").isvalidPassword() && (passwordField.text ?? "") == (confirmPasswordField.text ?? "") && (nameField.text ?? "") != "" ? registerButton.setAsEnabled() : registerButton.setAsDisabled()
    }

    func bindViewModel() {
        viewModel.isLoadingData.bind { [weak self] isLoading in
            guard let isLoading = isLoading else {
                return
            }
            DispatchQueue.main.async {
                if isLoading {
                    self?.activityIndicator.show()
                } else {
                    self?.activityIndicator.hide()
                }
            }
        }

        viewModel.showError.bind { message in
            guard let message = message else {
                return
            }
            AppToastView.shared.showToast(message: message, toastType: .error)
        }

        viewModel.token.bind { token in
            guard let token = token else {
                return
            }
            AppUserData.shared.token = token
            let nextVC = AppController.shared.employeesListing
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
}
