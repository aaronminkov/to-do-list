//
//  ToDoListViewViewModel.swift
//  ToDoList
//
//  Created by Aaron Minkov on 7/7/24.
//

import FirebaseFirestore
import Foundation

/// ViewModel for list of items view
/// Primary tab
class ToDoListViewViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var showingNewItemView = false
    @Published var selectedSortOption: SortOption {
        didSet {
            UserDefaults.standard.set(selectedSortOption.rawValue, forKey: "toDoListSortOption")
        }
    }
    @Published var selectedSortOrder: SortOrder {
        didSet {
            UserDefaults.standard.set(selectedSortOrder.rawValue, forKey: "toDoListSortOrder")
        }
    }

    private let userId: String

    init(userId: String) {
        self.userId = userId
        self.selectedSortOption = SortOption(rawValue: UserDefaults.standard.string(forKey: "toDoListSortOption") ?? SortOption.dueDate.rawValue) ?? .dueDate
        self.selectedSortOrder = SortOrder(rawValue: UserDefaults.standard.string(forKey: "toDoListSortOrder") ?? SortOrder.earliestFirst.rawValue) ?? .earliestFirst
    }

    /// Delete to do list item
    /// - Parameter id: item id to delete
    func delete(id: String) {
        let db = Firestore.firestore()

        db.collection("users")
            .document(userId)
            .collection("todos")
            .document(id)
            .delete()
    }

    func sortItems(_ items: [ToDoListItem]) -> [ToDoListItem] {
        var sortedItems: [ToDoListItem]
        switch selectedSortOption {
        case .dueDate:
            sortedItems = items.sorted { $0.dueDate < $1.dueDate }
        case .creationDate:
            sortedItems = items.sorted { $0.created < $1.created }
        case .title:
            sortedItems = items.sorted { $0.title.localizedCaseInsensitiveCompare($1.title) == .orderedAscending }
        }

        if selectedSortOrder == .latestFirst {
            sortedItems.reverse()
        }

        return sortedItems
    }
}

enum SortOption: String, CaseIterable, Identifiable {
    var id: String { self.rawValue }

    case dueDate = "Due Date"
    case creationDate = "Creation Date"
    case title = "Title"
}

enum SortOrder: String, CaseIterable, Identifiable {
    var id: String { self.rawValue }

    case earliestFirst = "Earliest First"
    case latestFirst = "Latest First"
}
