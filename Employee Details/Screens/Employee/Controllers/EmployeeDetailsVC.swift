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

    // MARK: - CONSTANTS AND VARIABLES
//    var viewModel: EmployeesListingVM = EmployeesListingVM()
//    let activityIndicator = ActivityIndicator()
    var employeesData:Employee?
    var monthlyPaymentsArray:[Monthly_payments] = []

    // MARK: - LOADING VIEW CONTROLLER
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    func configureView(){
        paymentsTableView.delegate = self
        paymentsTableView.dataSource = self
        paymentsTableView.register(UINib(nibName: "PaymentsTVC", bundle: nil), forCellReuseIdentifier: "PaymentsTVC_id")
        if let data = employeesData{
            nameLbl.text = "\((data.first_name ?? "").capitalized) \((data.last_name ?? "").capitalized)"
            roleLbl.text = data.designation ?? ""
            numberLbl.text = data.mobile_number ?? ""
            emailLbl.text = data.email ?? ""
            dateLbl.text = data.date_of_birth ?? ""
            genderLbl.text = data.gender ?? ""
            addressLbl.text = data.address ?? ""
            fileUpdateLbl.text = "Updated \(data.created_at ?? "")"
            salarySchemeMonths.text = "\(data.contract_period ?? 0) Months"
            salaryAmountLbl.text = "₹ \(data.total_salary ?? 0)"
            monthlyPaymentsArray = data.monthly_payments ?? []
            paymentsTableViewHeight.constant = CGFloat(200 * monthlyPaymentsArray.count)
            paymentsTableView.reloadData()
        }
    }

    // MARK: - BUTTON ACTIONS
     @IBAction func backAction(_ sender: UIButton) {
         self.navigationController?.popViewController(animated: true)
     }

    @IBAction func viewFileAction(_ sender: UIButton) {
        
    }
    
    // MARK: - TABLE VIEW
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return monthlyPaymentsArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData = monthlyPaymentsArray[indexPath.item]
        let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentsTVC_id") as! PaymentsTVC
        cell.setData(data: cellData)
        cell.deleteButton.isHidden = true
        cell.monthLbl.text = "Month \(indexPath.item + 1)"
        return cell
    }

}
