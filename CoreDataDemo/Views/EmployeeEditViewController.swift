//
//  EmployeeEditViewController.swift
//  CoreDataDemo
//
//  Created by GOURAVM on 14/06/24.
//

import UIKit

class EmployeeEditViewController: UIViewController {
    
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var profilePicImageView: UIImageView!
    
    var employeeManager = EmployeeManager()
    
    var selectedEmployee: Employee?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Employee Details"
        
        fetchEmployeeData()
        
        updateButton.addTarget(self, action: #selector(updateAction(button:)), for: .touchUpInside)
        deleteButton.addTarget(self, action: #selector(deleteAction(button:)), for: .touchUpInside)
    }
    
    @objc func updateAction(button: UIButton) {
        updateEmployee()
    }
    
    @objc func deleteAction(button: UIButton) {
        deleteEmployee()
    }
    
    func fetchEmployeeData() {
        guard let id = selectedEmployee?.id else { return }
        let employeeData = employeeManager.get(byIdentifier: id)
        
        nameTextfield.text = employeeData?.name
        emailTextfield.text = employeeData?.email
        
        if let imageData = employeeData?.profilePic {
            profilePicImageView.image = UIImage(data: imageData)
        }
    }
    
    func deleteEmployee() {
        guard let id = selectedEmployee?.id else { return }
        if employeeManager.delete(id: id) {
            let alert = UIAlertController(title: "Record Deleted", message: nil, preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                self.navigationController?.popViewController(animated: true)
            }))
            self.present(alert, animated: true)
        }
    }
    
    func updateEmployee() {
        guard var employee = selectedEmployee else { return }
        employee.email = emailTextfield.text
        employee.name = nameTextfield.text
        if employeeManager.update(employee: employee) {
            let alert = UIAlertController(title: "Record Updated", message: nil, preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                self.navigationController?.popViewController(animated: true)
            }))
            self.present(alert, animated: true)
        }
    }
}
