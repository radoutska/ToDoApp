//
//  ViewModel.swift
//  ToDoApp
//
//  Created by Anna Radoutska on 05.06.2024.
//

import Foundation
import Observation
import CoreData

class ViewModel: ObservableObject {
    @Published var tasks: [Item] = []
    @Published var groups: [Group] = []
    
    private var dataManager = CoreDataStack.shared
    
    init() {
        fetchTasks()
        fetchGroups()
    }
    
    func addGroup(title: String) {
        dataManager.saveNewGroup(title: title)
        fetchGroups()
    }
    
    func fetchTasks() {
        tasks = dataManager.fetchTasks()
        print(tasks)
    }
    
    func fetchTasksOfGroup(groupName: String) {
        tasks = dataManager.fetchTasksOfGroup(groupName: groupName)
    }
    
    func fetchGroups() {
        DispatchQueue.main.async {
            self.groups = self.dataManager.fetchGroups()
        }
    }
    
    func addTask(title: String, deadline: Date, status: String) {
        dataManager.saveNewTask(title: title, deadline: deadline, status: status, group: nil)
        fetchTasks()
    }
    
    func deleteTask(item: Item) {
        dataManager.deleteTask(task: item)
    }
    
    func deleteGroup(name: String) {
        dataManager.deleteGroup(name: name)
    }
}
