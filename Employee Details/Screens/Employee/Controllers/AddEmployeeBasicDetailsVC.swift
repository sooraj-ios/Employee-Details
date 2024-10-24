//
//  AddEmployeeBasicDetailsVC.swift
//  Employee Details
//
//  Created by Sooraj R on 24/10/24.
//

import UIKit

class AddEmployeeBasicDetailsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    // MARK: - BUTTON ACTIONS
     @IBAction func backAction(_ sender: UIButton) {
         self.navigationController?.popViewController(animated: true)
     }

    @IBAction func nextAction(_ sender: UIButton) {
        let nextVC = AppController.shared.addEmployeeContactDetails
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
