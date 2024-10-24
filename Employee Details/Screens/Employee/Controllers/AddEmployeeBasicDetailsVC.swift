//
//  AddEmployeeBasicDetailsVC.swift
//  Employee Details
//
//  Created by Sooraj R on 24/10/24.
//

import UIKit

class AddEmployeeBasicDetailsVC: UIViewController {
    // MARK: - IBOUTLETS
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var dateOfBirthField: UITextField!
    @IBOutlet weak var designationField: UITextField!
    @IBOutlet weak var genderField: UITextField!
    @IBOutlet weak var importedFileView: CurvedView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    // MARK: - BUTTON ACTIONS
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func editImageAction(_ sender: UIButton) {
    }

    @IBAction func fileViewAction(_ sender: UIButton) {
    }

    @IBAction func uploadFileAction(_ sender: UIButton) {

    }

    @IBAction func nextAction(_ sender: UIButton) {
        let nextVC = AppController.shared.addEmployeeContactDetails
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
