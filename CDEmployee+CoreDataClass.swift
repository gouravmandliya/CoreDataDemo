//
//  CDEmployee+CoreDataClass.swift
//  CoreDataDemo
//
//  Created by GOURAVM on 14/06/24.
//
//

import Foundation
import CoreData

@objc(CDEmployee)
public class CDEmployee: NSManagedObject {

    func convertToEmployee() -> Employee {
       return Employee(name: self.name, email: self.email, profilePic: self.profilePic, id: self.id!)
    }
}
