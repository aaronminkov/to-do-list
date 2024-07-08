//
//  User.swift
//  ToDoList
//
//  Created by Aaron Minkov on 7/7/24.
//

import Foundation

struct User: Codable {
    let id: String
    let name: String
    let email: String
    let joined: TimeInterval
}
