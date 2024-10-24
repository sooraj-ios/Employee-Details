//
//  EmployeeDetailsVC.swift
//  Employee Details
//
//  Created by Sooraj R on 24/10/24.
//

import UIKit

class EmployeeDetailsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // MARK: - IBOUTLETS
    @IBOutlet weak var paymentsTableView: UITableView!
    @IBOutlet weak var paymentsTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var profileImageLbl: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var roleLbl: UILabel!
    @IBOutlet weak var numberLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var genderLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var fileNameLbl: UILabel!
    @IBOutlet weak var fileUpdateLbl: UILabel!
    @IBOutlet weak var salarySchemeMonths: UILabel!
    @IBOutlet weak var salaryAmountLbl: UILabel!
    
    // MARK: - LOADING VIEW CONTROLLER
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    func configureView(){
        paymentsTableView.delegate = self
        paymentsTableView.dataSource = self
        paymentsTableView.register(UINib(nibName: "PaymentsTVC", bundle: nil), forCellReuseIdentifier: "PaymentsTVC_id")
        paymentsTableViewHeight.constant = 190 * 3
    }

    // MARK: - BUTTON ACTIONS
     @IBAction func backAction(_ sender: UIButton) {
         self.navigationController?.popViewController(animated: true)
     }

    @IBAction func viewFileAction(_ sender: UIButton) {
    }
    
    // MARK: - TABLE VIEW
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentsTVC_id") as! PaymentsTVC
        return cell
    }

}
