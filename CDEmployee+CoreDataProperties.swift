//
//  CDEmployee+CoreDataProperties.swift
//  CoreDataDemo
//
//  Created by GOURAVM on 14/06/24.
//
//

import Foundation
import CoreData


extension CDEmployee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDEmployee> {
        return NSFetchRequest<CDEmployee>(entityName: "CDEmployee")
    }

    @NSManaged public var name: String?
    @NSManaged public var email: String?
    @NSManaged public var profilePic: Data?
    @NSManaged public var id: UUID?

}

extension CDEmployee : Identifiable {

}
