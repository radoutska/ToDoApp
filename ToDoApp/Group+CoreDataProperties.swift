//
//  Group+CoreDataProperties.swift
//  ToDoApp
//
//  Created by Anna Radoutska on 05.06.2024.
//
//

import Foundation
import CoreData


extension Group {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Group> {
        return NSFetchRequest<Group>(entityName: "Group")
    }

    @NSManaged public var name: String?
    @NSManaged public var itemGroup: NSSet?

}

// MARK: Generated accessors for itemGroup
extension Group {

    @objc(addItemGroupObject:)
    @NSManaged public func addToItemGroup(_ value: Item)

    @objc(removeItemGroupObject:)
    @NSManaged public func removeFromItemGroup(_ value: Item)

    @objc(addItemGroup:)
    @NSManaged public func addToItemGroup(_ values: NSSet)

    @objc(removeItemGroup:)
    @NSManaged public func removeFromItemGroup(_ values: NSSet)

}

extension Group : Identifiable {

}
