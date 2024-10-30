//
//  AddEmployeeSalarySchemeVC.swift
//  Employee Details
//
//  Created by Sooraj R on 24/10/24.
//

import UIKit

class AddEmployeeSalarySchemeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // MARK: - IBOUTLETS
    @IBOutlet weak var paymentsTableView: UITableView!
    @IBOutlet weak var paymentsTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var months3Button: BorderButton!
    @IBOutlet weak var months6Button: BorderButton!
    @IBOutlet weak var months12Button: BorderButton!
    @IBOutlet weak var salarySlider: UISlider!
    @IBOutlet weak var totalSalaryLbl: UIButton!
    @IBOutlet weak var remainingSalary: UIButton!
    @IBOutlet weak var remainingPercentage: UIButton!
    @IBOutlet weak var remainingMonths: UIButton!
    @IBOutlet weak var addButton: PrimaryButton!

    // MARK: - CONSTANTS AND VARIABLES
    var viewModel: AddEmployeeSalarySchemeVM = AddEmployeeSalarySchemeVM()
    let activityIndicator = ActivityIndicator()
    var basicDetailsCollected:BasicDetailsModel?
    var contactDetailsCollected: ContactDetailsModel?
    var selectedContractPeriod = 3
    var monthlyPaymentsArray:[Monthly_payments] = []

    // MARK: - LOADING VIEW CONTROLLER
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        bindViewModel()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setContractPeriodButtonsUI(button: months3Button)
    }

    func configureView(){
        totalSalaryLbl.setTitle("₹ \(salarySlider.value)", for: .normal)
        paymentsTableView.delegate = self
        paymentsTableView.dataSource = self
        paymentsTableView.register(UINib(nibName: "PaymentsTVC", bundle: nil), forCellReuseIdentifier: "PaymentsTVC_id")
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
    }

    // MARK: - BUTTON ACTIONS
     @IBAction func backAction(_ sender: UIButton) {
         self.navigationController?.popViewController(animated: true)
     }

    @IBAction func contractPeriodButton(_ sender: BorderButton) {
        setContractPeriodButtonsUI(button: sender)
        selectedContractPeriod = sender.tag
        addButton.setTitle("Add Monthly Payment (1/\(sender.tag))", for: .normal)
        monthlyPaymentsArray = []
        paymentsTableViewHeight.constant = 0
        paymentsTableView.reloadData()
    }

    @IBAction func sliderAction(_ sender: UISlider) {
        totalSalaryLbl.setTitle("₹ \(Int(sender.value))", for: .normal)
    }
    
    @IBAction func addAction(_ sender: UIButton) {
        if self.monthlyPaymentsArray.count == self.selectedContractPeriod{
            addEmployee()
        }else{
            let nextVC = AppController.shared.addPayment
            nextVC.totalAmount = Int(salarySlider.value)
            nextVC.minimumDate = self.monthlyPaymentsArray.count == 0 ? Date() : stringToDate(dateString: self.monthlyPaymentsArray.last?.payment_date ?? "")
            if let presentationController = nextVC.presentationController as? UISheetPresentationController {
                presentationController.detents = [.medium()]
            }
            nextVC.paymentClosure = { payment in
                self.monthlyPaymentsArray.append(payment)
                self.paymentsTableViewHeight.constant = CGFloat(self.monthlyPaymentsArray.count * 200)
                self.paymentsTableView.reloadData()
                if self.monthlyPaymentsArray.count == self.selectedContractPeriod{
                    self.addButton.setTitle("Save", for: .normal)
                }else{
                    self.addButton.setTitle("Add Monthly Payment (\(self.monthlyPaymentsArray.count)/\(self.selectedContractPeriod))", for: .normal)
                }
            }
            self.present(nextVC, animated: true)
        }
    }

    // MARK: - FUNCTIONS
    func setContractPeriodButtonsUI(button: BorderButton){
        for item in [months3Button, months6Button, months12Button]{
            if item == button{
                item?.setAsSelected()
            }else{
                item?.setAsUnSelected()
            }
        }
    }

    func stringToDate(dateString: String, neededFormat: String = "dd-MM-yyyy") -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = neededFormat
        return formatter.date(from: dateString) ?? Date()
    }


    func addEmployee(){
        guard let basicDetails = basicDetailsCollected else {return}
        guard let contactDetails = contactDetailsCollected else {return}
        var parameters = [
          ["key": "first_name", "value": basicDetails.firstName, "type": "text"],
          ["key": "last_name","value": basicDetails.lastName,"type": "text"],
          ["key": "date_of_birth","value": basicDetails.dateOfBirth,"type": "text"],
          ["key": "designation","value": "\(basicDetails.designation)","type": "text"],
          ["key": "gender","value": basicDetails.gender,"type": "text"],
          ["key": "mobile_number","value": contactDetails.mobile,"type": "text"],
          ["key": "email","value": contactDetails.email,"type": "text"],
          ["key": "address","value": contactDetails.address,"type": "text"],
          ["key": "profile_pic","src": basicDetails.profileImagePath,"type": "file"],
          ["key": "resume","src": basicDetails.documentPath,"type": "file"],
          ["key": "contract_period","value": "\(selectedContractPeriod)","type": "text"],
          ["key": "total_salary","value": "\(Int(salarySlider.value))","type": "text"]] as [[String: Any]]

        for (index, item) in monthlyPaymentsArray.enumerated(){
            let dateParameter = ["key": "monthly_payments[\(index)][payment_date]","value": item.payment_date ?? "","type": "text"]
            parameters.append(dateParameter)
            let percentageParameter = ["key": "monthly_payments[\(index)][amount_percentage]","value": "\(item.amount_percentage ?? 0)","type": "text"]
            parameters.append(percentageParameter)
            let remarkParameter = ["key": "monthly_payments[\(index)][remarks]","value": item.remarks ?? "","type": "text"]
            parameters.append(remarkParameter)
            let amountParameter = ["key": "monthly_payments[\(index)][amount]","value": "\(item.amount ?? 0)","type": "text"]
            parameters.append(amountParameter)
        }
        viewModel.addEmployee(parameters: parameters)
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
