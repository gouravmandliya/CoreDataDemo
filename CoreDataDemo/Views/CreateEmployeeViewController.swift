//
//  CreateEmployeeViewController.swift
//  CoreDataDemo
//
//  Created by GOURAVM on 14/06/24.
//

import UIKit

class CreateEmployeeViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageViewProfilePic: UIImageView!
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    private let employeeManager = EmployeeManager()
    
    private var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Create Employee Record"
        
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        debugPrint(path)
        
        setupGestureRecognizer()
        saveButton.addTarget(self, action: #selector(saveAction(button:)), for: .touchUpInside)
    }
    
    private func setupGestureRecognizer() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(addImagePickerAction(tapGestureRecognizer:)))
        imageViewProfilePic.isUserInteractionEnabled = true
        imageViewProfilePic.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func addImagePickerAction(tapGestureRecognizer: UITapGestureRecognizer) {
        imagePicker.modalPresentationStyle = UIModalPresentationStyle.currentContext
        imagePicker.delegate = self
        self.present(imagePicker, animated: true)
    }
    
    @objc func saveAction(button: UIButton) {
        let employee = Employee(name: nameTextfield.text, email: emailTextfield.text, profilePic: imageViewProfilePic.image?.pngData(), id: UUID())
        employeeManager.create(employee: employee)
        
        let employeeListVC = storyboard?.instantiateViewController(withIdentifier: "EmployeeListViewController") as! EmployeeListViewController
        self.navigationController?.pushViewController(employeeListVC, animated: true)
    }
}

// MARK: UIImagePickerControllerDelegate

extension CreateEmployeeViewController: UIImagePickerControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            self.imageViewProfilePic.image = image
            return
        }

        if let image = info[.originalImage] as? UIImage {
            self.imageViewProfilePic.image = image
        } else {
            print("Other source")
        }
        self.dismiss(animated: true)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true)
    }
}
