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
    
    // MARK: - LOADING VIEW CONTROLLER
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setContractPeriodButtonsUI(button: months3Button)
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

    @IBAction func contractPeriodButton(_ sender: BorderButton) {
        setContractPeriodButtonsUI(button: sender)
    }
    
    @IBAction func addAction(_ sender: UIButton) {
        let nextVC = AppController.shared.addPayment
        if let presentationController = nextVC.presentationController as? UISheetPresentationController {
            presentationController.detents = [.medium()]
        }
        self.present(nextVC, animated: true)
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
