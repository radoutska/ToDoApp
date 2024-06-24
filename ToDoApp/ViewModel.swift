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
    
    private var selectedTasks: [Item] = []
    
    private var dataManager = CoreDataStack.shared
    
    init() {
        fetchTasks()
        fetchGroups()
    }
    
    func addGroup(title: String, tasks: [Item]) {
        dataManager.saveNewGroup(title: title, tasks: tasks)
        fetchGroups()
    }
    
    func fetchTasks() {
        tasks = dataManager.fetchTasks().filter { $0.status != ToDoStatus.finished.description }.sorted(by: {
            $0.deadline?.compare($1.deadline!) == .orderedAscending
        })
    }
    
    func fetchTasksOfGroup(groupName: String) {
        tasks = dataManager.fetchTasksOfGroup(groupName: groupName)
    }
    
    func fetchGroups() {
        groups = dataManager.fetchGroups()
    }
    
    func addTask(title: String, deadline: Date, status: String, group: String?) {
        dataManager.saveNewTask(title: title, deadline: deadline, status: status, group: group)
        fetchTasks()
    }
    
    func deleteTask(item: Item) {
        dataManager.deleteTask(task: item)
    }
    
    func deleteGroup(name: String) {
        dataManager.deleteGroup(name: name)
    }
    
    func addTaskToSelected(item: Item) {
        if selectedTasks.contains(where: { $0.id == item.id }) {
            selectedTasks.removeAll(where: { $0.id == item.id })
        }
        else {
            selectedTasks.append(item)
        }
    }
}
