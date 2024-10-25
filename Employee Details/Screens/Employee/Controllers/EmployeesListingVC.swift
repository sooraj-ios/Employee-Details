//
//  EmployeesListingVC.swift
//  Employee Details
//
//  Created by Sooraj R on 24/10/24.
//

import UIKit

class EmployeesListingVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // MARK: - IBOUTLETS
    @IBOutlet weak var employeeListingTableView: UITableView!
    @IBOutlet weak var noDataLbl: UILabel!

    // MARK: - CONSTANTS AND VARIABLES
    var viewModel: EmployeesListingVM = EmployeesListingVM()
    let activityIndicator = ActivityIndicator()
    var employeesArray:[Employee] = []

    // MARK: - LOADING VIEW CONTROLLER
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        bindViewModel()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.getEmployees(page: 1)
    }

    func configureView(){
        employeeListingTableView.delegate = self
        employeeListingTableView.dataSource = self
        employeeListingTableView.register(UINib(nibName: "EmployeesListTVC", bundle: nil), forCellReuseIdentifier: "EmployeesListTVC_id")
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

        viewModel.employees.bind { employees in
            guard let employees = employees else {
                return
            }
            self.employeesArray = employees.data ?? []
            self.employeeListingTableView.reloadData()
            self.noDataLbl.isHidden = !(employees.data?.isEmpty ?? false)
        }

    }

    // MARK: - BUTTON ACTIONS
    @IBAction func addAction(_ sender: UIButton) {
        let nextVC = AppController.shared.addEmployeeBasicDetails
        self.navigationController?.pushViewController(nextVC, animated: true)
    }

    // MARK: - TABLE VIEW
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employeesArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData = employeesArray[indexPath.item]
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeesListTVC_id") as! EmployeesListTVC
        cell.setData(data: cellData)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = AppController.shared.employeeDetails
        nextVC.employeesData = employeesArray[indexPath.item]
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
