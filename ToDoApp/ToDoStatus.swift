//
//  ToDoStatus.swift
//  ToDoApp
//
//  Created by Anna Radoutska on 01.06.2024.
//

import Foundation
import SwiftUI

enum ToDoStatus: String, CaseIterable, Identifiable {
    var id: Self { self }
    case open
    case pending
    case blocked
    case finished
    
    var description: String {
        switch self {
        case .open:
            return NSLocalizedString("Open", comment: "ToDo case")
        case .blocked:
            return NSLocalizedString("Blocked", comment: "ToDo case")
        case .finished:
            return NSLocalizedString("Finished", comment: "ToDo case")
        case .pending:
            return NSLocalizedString("Pending", comment: "ToDo case")
        }
    }
    
    var color: Color {
        switch self {
        case .open:
            Color.black
        case .pending:
            Color.green
        case .blocked:
            Color.blue
        case .finished:
            Color.gray
        }
    }
}
