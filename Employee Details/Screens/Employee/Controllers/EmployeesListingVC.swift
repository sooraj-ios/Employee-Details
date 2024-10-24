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

    // MARK: - CONSTANTS AND VARIABLES
    var employeesArray:[String] = []

    // MARK: - LOADING VIEW CONTROLLER
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    func configureView(){
        employeeListingTableView.delegate = self
        employeeListingTableView.dataSource = self
        employeeListingTableView.register(UINib(nibName: "EmployeesListTVC", bundle: nil), forCellReuseIdentifier: "EmployeesListTVC_id")
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
        return 10//employeesArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeesListTVC_id") as! EmployeesListTVC
        return cell
    }
}
