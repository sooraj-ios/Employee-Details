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

    // MARK: - VARIABLES AND CONSTANTS
    var viewModel: LoginVM = LoginVM()
    let activityIndicator = ActivityIndicator()

    // MARK: - LOADING VIEW CONTROLLER
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        bindViewModel()
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
        viewModel.signIn(email: emailField.text ?? "", password: passwordField.text ?? "")
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
        _ = (emailField.text ?? "").isValidEmail() && (passwordField.text ?? "").isvalidPassword() ? signinButton.setAsEnabled() : signinButton.setAsDisabled()
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

