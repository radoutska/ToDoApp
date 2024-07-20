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
    
    @Published var selectedTasks: Array<Item> = []
    
    private var dataManager = CoreDataStack.shared
    
    init() {
        fetchTasks()
        fetchGroups()
    }
    
    func addGroup(title: String) {
        dataManager.saveNewGroup(title: title, tasks: selectedTasks)
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
    
    func editTask(id: UUID, title: String, deadline: Date, status: String, group: String?) {
        let existingTask = tasks.first { $0.id == id }
        guard let existingTask = existingTask else { return }
        dataManager.updateTask(id: existingTask.id, title: title, deadline: deadline, status: status, group: group)
        fetchTasks()
    }
    
    func deleteTask(item: Item, completion: @escaping (Bool) -> ()) {
        dataManager.deleteTask(task: item) { isSuccess in
            if isSuccess {
                self.fetchTasks()
            }
            completion(isSuccess)
        }
    }
    
    func deleteGroup(name: String) {
        dataManager.deleteGroup(name: name)
    }
    
    func toggleSelection(for item: Item) {
        if selectedTasks.contains(item) {
            selectedTasks.removeAll(where: { $0.id == item.id })
        } else {
            selectedTasks.append(item)
        }
    }
    
    func isSelected(item: Item) -> Bool {
        return selectedTasks.contains(item)
    }
    
    // TODO: Separate date formatter
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateStyle = .medium
        return formatter
    }()
    
    func mediumDateDeadline(for date: Date?) -> String {
        guard let date = date else { return "" }
        Self.dateFormatter.dateStyle = .medium
        return Self.dateFormatter.string(from: date)
    }
    
    func dateDeadline(for date: Date?) -> String {
        guard let date = date else { return "" }
        Self.dateFormatter.setLocalizedDateFormatFromTemplate("dMMM")
        return Self.dateFormatter.string(from: date)
    }
    
    func fullDateDeadline(for date: Date?) -> String {
        guard let date = date else { return "" }
        Self.dateFormatter.timeStyle = .short
        return Self.dateFormatter.string(from: date)
    }
}
