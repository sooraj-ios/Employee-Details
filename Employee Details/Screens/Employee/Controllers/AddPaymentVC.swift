//
//  AddPaymentVC.swift
//  Employee Details
//
//  Created by Sooraj R on 24/10/24.
//

import UIKit

class AddPaymentVC: UIViewController {
    // MARK: - IBOUTLETS
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var amountPercentageField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    // MARK: - BUTTON ACTIONS
     @IBAction func saveAction(_ sender: UIButton) {
         self.dismiss(animated: true)
     }

}
