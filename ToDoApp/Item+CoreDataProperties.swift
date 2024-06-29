//
//  Item+CoreDataProperties.swift
//  ToDoApp
//
//  Created by Anna Radoutska on 05.06.2024.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var deadline: Date?
    @NSManaged public var id: UUID
    @NSManaged public var status: String?
    @NSManaged public var title: String
    @NSManaged public var itemGroup: Group?

}

extension Item : Identifiable {

}
