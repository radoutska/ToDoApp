//
//  ToDoStatus.swift
//  ToDoApp
//
//  Created by Anna Radoutska on 01.06.2024.
//

import Foundation

enum ToDoStatus: String, CaseIterable, Identifiable {
    var id: Self { self }
    case open
    case pending
    case blocked
    case finished
    
    var description: String { rawValue }
}
