//
//  Group+CoreDataClass.swift
//  ToDoApp
//
//  Created by Anna Radoutska on 05.06.2024.
//
//

import Foundation
import CoreData

@objc(Group)
public class Group: NSManagedObject {
    
}

extension Group {
    var percent: Int {
        guard let items = itemGroup else { return 100 }
        var counter = 0
        if let groupItems = items as? Set<Item> {
            groupItems.forEach { item in
                counter = counter + (item.status == ToDoStatus.finished.description ? 1 : 0)
            }
            if items.count == 0 {
                return 100
            }
                return Int(counter/items.count) * 100
        }
        return 0
    }
}
