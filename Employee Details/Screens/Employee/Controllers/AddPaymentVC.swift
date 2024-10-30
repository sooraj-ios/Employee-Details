//
//  AddPaymentVC.swift
//  Employee Details
//
//  Created by Sooraj R on 24/10/24.
//

import UIKit

class AddPaymentVC: UIViewController, UITextViewDelegate{
    // MARK: - IBOUTLETS
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var amountPercentageField: UITextField!
    @IBOutlet weak var remarkField: UITextView!
    @IBOutlet weak var saveButton: PrimaryButton!

    var paymentClosure: ((Monthly_payments) -> ())!
    var totalAmount = 0
    var minimumDate = Date()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    func configureView(){
        saveButton.setAsDisabled()
        dateField.addTarget(self, action: #selector(typing(_ :)), for: .editingChanged)
        amountPercentageField.addTarget(self, action: #selector(typing(_ :)), for: .editingChanged)
        remarkField.delegate = self
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
        _ = (dateField.text ?? "") != "" && (amountPercentageField.text ?? "") != "" && (remarkField.text ?? "") != "" ? saveButton.setAsEnabled() : saveButton.setAsDisabled()
    }

    func dateToString(date:Date, neededFormat:String = "dd-MM-yyyy") -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter.string(from: date)
    }

    func calculatePercentageAmount(totalAmount: Int, percentage: Int) -> Int {
        return Int(Double(totalAmount) * (Double(percentage) / 100.0))
    }

    // MARK: - BUTTON ACTIONS
    @IBAction func dateAction(_ sender: UIButton) {
        let nextVC = AppController.shared.datePicker
        nextVC.modalPresentationStyle = .overCurrentContext
        nextVC.modalTransitionStyle = .crossDissolve
        nextVC.minimumDate = minimumDate
        nextVC.selectedDateClosure = { selectedDate in
            self.dateField.text = self.dateToString(date: selectedDate)
            self.checkValidations()
        }
        self.present(nextVC, animated: true)
    }

     @IBAction func saveAction(_ sender: UIButton) {
         let amount = calculatePercentageAmount(totalAmount: totalAmount, percentage: Int(amountPercentageField.text ?? "") ?? 0)
         paymentClosure(Monthly_payments(id: 0, payment_date: dateField.text ?? "", amount: amount, amount_percentage: Int(amountPercentageField.text ?? "") ?? 0, remarks: remarkField.text ?? "", created_at: ""))
         self.dismiss(animated: true)
     }

}
