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
    
    var description: String { rawValue }
    
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
