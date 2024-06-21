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
        return container
    }()
    
    func saveNewTask(title: String, deadline: Date, status: String, group: Group?) {
        let newItem = Item(context: viewContext)
        newItem.id = UUID()
        newItem.title = title
        newItem.deadline = deadline
        newItem.status = status
//        newItem.itemGroup = group
        do {
            try self.viewContext.save()
        } catch {
            print("whoops \(error.localizedDescription)")
        }
    }
    
    func saveNewGroup(title: String) {
        let newGroup = Group(context: viewContext)
        newGroup.name = title
        do {
            try self.viewContext.save()
        } catch {
            print("whoops \(error.localizedDescription)")
        }
    }
    
    func saveItemToGroup(title: String, deadline: Date, status: String, groupName: String) {
        let fetchRequest = NSFetchRequest<Group>(entityName: "Group")
        let queryPredicate = NSPredicate(format: "name == %@", groupName)
        fetchRequest.predicate = queryPredicate
        do {
            let response = try viewContext.fetch(fetchRequest)
            guard let group = response.first else { return }
            saveNewTask(title: title, deadline: deadline, status: status, group: group)
        } catch {
            let group = Group(context: viewContext)
            group.name = groupName
            saveNewTask(title: title, deadline: deadline, status: status, group: group)
        }
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
