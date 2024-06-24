//
//  CoreDataStack.swift
//  ToDoApp
//
//  Created by Anna Radoutska on 01.06.2024.
//

import Foundation
import CoreData

class CoreDataStack: ObservableObject {
    static let shared = CoreDataStack()
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ToDoList")
        container.loadPersistentStores { _, error in
            if let error {
                fatalError("Failed to load persistent stores: \(error.localizedDescription)")
            }
        }
        container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        return container
    }()
    
    func saveNewTask(title: String, deadline: Date, status: String, group: String?) {
        let newItem = Item(context: viewContext)
        let itemId = UUID()
        newItem.id = itemId
        newItem.title = title
        newItem.deadline = deadline
        newItem.status = status
        if let groupName = group {
            saveItemToGroup(item: newItem, groupName: groupName)
        }
        do {
            try self.viewContext.save()
        } catch {
            print("whoops \(error.localizedDescription)")
        }
    }
    
    func saveNewGroup(title: String, tasks: [Item]) {
        if fetchGroups().contains(where: { $0.name == title }) {
            print("Can't save with the same name")
            return
        }
        let newGroup = Group(context: viewContext)
        newGroup.name = title
        for each in tasks {
            newGroup.addToItemGroup(each)
        }
        do {
            try self.viewContext.save()
        } catch {
            print("whoops \(error.localizedDescription)")
        }
    }
    
    func saveItemToGroup(item: Item, groupName: String) {
        let fetchRequest = NSFetchRequest<Group>(entityName: "Group")
        let queryPredicate = NSPredicate(format: "name == %@", groupName)
        fetchRequest.predicate = queryPredicate
        do {
            let response = try viewContext.fetch(fetchRequest)
            guard let group = response.first else { return }
            group.addToItemGroup(item)
            try self.viewContext.save()
        } catch {
            // TODO: Error handling
        }
    }
    
    func getItem(itemId: UUID) -> Item? {
        let fetchRequest = NSFetchRequest<Item>(entityName: "Item")
        let queryPredicate = NSPredicate(format: "id == %@", itemId as NSUUID)
        fetchRequest.predicate = queryPredicate
        do {
            let response = try viewContext.fetch(fetchRequest)
            guard let item = response.first else { return nil }
            return item
        } catch {
           // TODO: Error handling
        }
        return nil
    }
    
    func fetchTasks() -> [Item] {
        let request = NSFetchRequest<Item>(entityName: "Item")
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }
    
    func fetchGroups() -> [Group] {
        let request = NSFetchRequest<Group>(entityName: "Group")
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }
    
    func fetchTasksOfGroup(groupName: String) -> [Item] {
        let request = NSFetchRequest<Group>(entityName: "Group")
        let queryPredicate = NSPredicate(format: "name == %@", groupName)
        request.predicate = queryPredicate
        do {
            let response = try viewContext.fetch(request)
            guard let group = response.first else { return [] }
            
            let tasksRequest = NSFetchRequest<Item>(entityName: "Item")
            let queryPredicate = NSPredicate(format: "itemGroup == %@", group)
            tasksRequest.predicate = queryPredicate
            let tasksResponse = try viewContext.fetch(tasksRequest)
            return tasksResponse
        } catch {
            let group = Group(context: viewContext)
            group.name = groupName
        }
        return []
    }
    
    func deleteTask(task: Item) {
        viewContext.delete(task)
        do {
            try viewContext.save()
        }
        catch {
            // TODO: Error handling
        }
    }
    
    func deleteAllData(_ entity: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try viewContext.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                viewContext.delete(objectData)
            }
        } catch let error {
            print("Detele all data in \(entity) error :", error)
        }
    }
    
    func deleteGroup(name: String) {
        let fetchRequest = NSFetchRequest<Group>(entityName: "Group")
        let queryPredicate = NSPredicate(format: "name == %@", name)
        fetchRequest.predicate = queryPredicate
        do {
            let response = try viewContext.fetch(fetchRequest)
            guard let group = response.first else { return }
            viewContext.delete(group)
        }
        catch {
            // TODO: Add error handling
        }
    }
}
