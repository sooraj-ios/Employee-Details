//
//  AddEmployeeContactDetailsVC.swift
//  Employee Details
//
//  Created by Sooraj R on 24/10/24.
//

import UIKit

class AddEmployeeContactDetailsVC: UIViewController {
    // MARK: - IBOUTLETS
    @IBOutlet weak var numberField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var addressTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // MARK: - BUTTON ACTIONS
     @IBAction func backAction(_ sender: UIButton) {
         self.navigationController?.popViewController(animated: true)
     }

    @IBAction func nextAction(_ sender: UIButton) {
        let nextVC = AppController.shared.addEmployeeSalaryScheme
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
