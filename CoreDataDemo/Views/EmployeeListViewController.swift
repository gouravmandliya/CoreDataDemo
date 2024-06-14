//
//  EmployeeListViewController.swift
//  CoreDataDemo
//
//  Created by GOURAVM on 14/06/24.
//

import UIKit

class EmployeeListViewController: UIViewController {

    @IBOutlet weak var employeesTableView: UITableView!
    
    private let employeeManager = EmployeeManager()
    
    var employees: [Employee] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Employee List"
        
        employeesTableView.delegate = self
        employeesTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchEmployees()
    }
    
    private func fetchEmployees() {
        guard  let employees = employeeManager.getAll() else { return }
        self.employees = employees
        DispatchQueue.main.async { [weak self] in
            self?.employeesTableView.reloadData()
        }
    }
}

extension EmployeeListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let employeeEditVC = storyboard?.instantiateViewController(withIdentifier: "EmployeeEditViewController") as! EmployeeEditViewController
        employeeEditVC.selectedEmployee = employees[indexPath.row]
        self.navigationController?.pushViewController(employeeEditVC, animated: true)
    }
}

extension EmployeeListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeCell") as! EmployeeCell
        cell.emailLabel.text = employees[indexPath.row].email
        cell.nameLabel.text = employees[indexPath.row].name
        if let imageData = employees[indexPath.row].profilePic {
            cell.profilePicImageView?.image = UIImage(data: imageData)
        }
        return cell
    }
}
