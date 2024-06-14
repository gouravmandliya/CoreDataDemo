//
//  EmployeeRepository.swift
//  CoreDataDemo
//
//  Created by GOURAVM on 14/06/24.
//

import CoreData

protocol EmployeeRepositoryDelegate {
    func create(employee: Employee)
    func delete(id: UUID) -> Bool
    func update(employee: Employee) -> Bool
    func getAll() -> [Employee]?
    func get(byIdentifier: UUID) -> Employee?
}


struct EmployeeRepository: EmployeeRepositoryDelegate {
    func create(employee: Employee) {
        let cdEmployee = CDEmployee(context: PersistentStorage.shared.context)
        cdEmployee.id = employee.id
        cdEmployee.name = employee.name
        cdEmployee.email = employee.email
        cdEmployee.profilePic = employee.profilePic
        
        PersistentStorage.shared.saveContext()
    }
    
    func delete(id: UUID) -> Bool {
        guard let cdEmployee = getCDEmployee(byIdentifier: id) else { return false }
        PersistentStorage.shared.context.delete(cdEmployee)
        return true
    }
    
    func update(employee: Employee) -> Bool {
        guard let cdEmployee = getCDEmployee(byIdentifier: employee.id) else { return false }
        cdEmployee.email = employee.email
        cdEmployee.name = employee.name
        cdEmployee.profilePic = employee.profilePic
        PersistentStorage.shared.saveContext()
        return true
    }
    
    func getAll() -> [Employee]? {
        let result = PersistentStorage.shared.fetchManagedObject(managedObject: CDEmployee.self)
        var employees = [Employee]()
        result?.forEach({ cdEmployee in
            employees.append(cdEmployee.convertToEmployee())
        })
        return employees
    }
    
    func get(byIdentifier identifier: UUID) -> Employee? {
        let fetchRequest = NSFetchRequest<CDEmployee>(entityName: "CDEmployee")
        fetchRequest.predicate = NSPredicate(format: "id==%@", identifier as CVarArg)
        do {
            guard let cdEmployee = try PersistentStorage.shared.context.fetch(fetchRequest).first else { return nil }
            return cdEmployee.convertToEmployee()
        } catch let error {
            debugPrint(error)
        }
        return nil
    }
    
    private func getCDEmployee(byIdentifier identifier: UUID) -> CDEmployee? {
        let fetchRequest = NSFetchRequest<CDEmployee>(entityName: "CDEmployee")
        fetchRequest.predicate = NSPredicate(format: "id==%@", identifier as CVarArg)
        do {
            guard let cdEmployee = try PersistentStorage.shared.context.fetch(fetchRequest).first else { return nil }
            return cdEmployee
        } catch let error {
            debugPrint(error)
        }
        return nil
    }
}
