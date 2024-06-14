//
//  EmployeeManager.swift
//  CoreDataDemo
//
//  Created by GOURAVM on 14/06/24.
//

import Foundation

struct EmployeeManager: EmployeeRepositoryDelegate {
    

    private let employeeRepository = EmployeeRepository()
    
    func create(employee: Employee) {
        employeeRepository.create(employee: employee)
    }
    
    func delete(id: UUID) -> Bool {
        employeeRepository.delete(id: id)
    }
    
    func update(employee: Employee) -> Bool {
        employeeRepository.update(employee: employee)
    }
    
    func getAll() -> [Employee]? {
        employeeRepository.getAll()
    }
    
    func get(byIdentifier: UUID) -> Employee? {
        employeeRepository.get(byIdentifier: byIdentifier)
    }
    
}
