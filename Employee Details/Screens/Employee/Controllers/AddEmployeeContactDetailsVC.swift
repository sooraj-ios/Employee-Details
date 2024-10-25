//
//  AddEmployeeContactDetailsVC.swift
//  Employee Details
//
//  Created by Sooraj R on 24/10/24.
//

import UIKit

class AddEmployeeContactDetailsVC: UIViewController, UITextViewDelegate{
    // MARK: - IBOUTLETS
    @IBOutlet weak var numberField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var addressTextView: UITextView!
    @IBOutlet weak var nextButton: PrimaryButton!

    var basicDetailsCollected:BasicDetailsModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    func configureView(){
        nextButton.setAsDisabled()
        numberField.addTarget(self, action: #selector(typing(_ :)), for: .editingChanged)
        emailField.addTarget(self, action: #selector(typing(_ :)), for: .editingChanged)
        addressTextView.delegate = self
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let textFieldText = textView.text,
              let rangeOfTextToReplace = Range(range, in: textFieldText) else {
            return false
        }
        let currentText = textFieldText.replacingCharacters(in: rangeOfTextToReplace, with: text)
        checkValidations()
        return true
    }

    @objc func typing(_ sender: UITextField){
        checkValidations()
    }

    func checkValidations(){
        _ = (numberField.text ?? "").count == 10 && (emailField.text ?? "").isValidEmail() && (addressTextView.text ?? "") != "" ? nextButton.setAsEnabled() : nextButton.setAsDisabled()
    }

    // MARK: - BUTTON ACTIONS
     @IBAction func backAction(_ sender: UIButton) {
         self.navigationController?.popViewController(animated: true)
     }

    @IBAction func nextAction(_ sender: UIButton) {
        let nextVC = AppController.shared.addEmployeeSalaryScheme
        nextVC.basicDetailsCollected = self.basicDetailsCollected
        nextVC.contactDetailsCollected = ContactDetailsModel(mobile: numberField.text ?? "", email: emailField.text ?? "", address: addressTextView.text ?? "")
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
