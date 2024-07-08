//
//  ToDoListItem.swift
//  ToDoList
//
//  Created by Aaron Minkov on 7/7/24.
//

import Foundation

struct ToDoListItem: Codable, Identifiable {
    let id: String
    let title: String
    let dueDate: TimeInterval
    let created: TimeInterval
    var isDone: Bool

    mutating func setDone(_ state: Bool) {
        isDone = state
    }
}
