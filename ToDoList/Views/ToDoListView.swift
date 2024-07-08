//
//  ToDoListView.swift
//  ToDoList
//
//  Created by Aaron Minkov on 7/7/24.
//

import FirebaseFirestoreSwift
import SwiftUI

struct ToDoListView: View {
    @StateObject var viewModel: ToDoListViewViewModel
    @FirestoreQuery var items: [ToDoListItem]

    init(userId: String) {
        self._viewModel = StateObject(
            wrappedValue: ToDoListViewViewModel(userId: userId)
        )
        self._items = FirestoreQuery(collectionPath: "users/\(userId)/todos")
    }

    var body: some View {
        NavigationView {
            VStack {
                List(sortedItems) { item in
                    ToDoListItemView(item: item)
                        .swipeActions {
                            Button("Delete") {
                                viewModel.delete(id: item.id)
                            }
                            .tint(.red)
                        }
                }
                .listStyle(.automatic)
            }
            .searchable(text: $viewModel.searchText)
            .navigationTitle("To Do List")
            .toolbar {
                Menu {
                    Menu {
                        Picker("Sort by", selection: $viewModel.selectedSortOption) {
                            ForEach(SortOption.allCases, id: \.self) { option in
                                Text(option.rawValue).tag(option)
                            }
                        }
                    Picker("Order by", selection: $viewModel.selectedSortOrder) {
                            ForEach(SortOrder.allCases, id: \.self) { option in
                                Text(option.rawValue).tag(option)
                            }
                        }
                    } label: {
                        Label("Sort By", systemImage: "arrow.up.arrow.down")
                        Text(viewModel.selectedSortOption.rawValue)
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                Button {
                    viewModel.showingNewItemView = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $viewModel.showingNewItemView) {
                NewItemView(newItemPresented: $viewModel.showingNewItemView)
            }
        }
    }

    var filteredItems: [ToDoListItem] {
        if viewModel.searchText.isEmpty {
            items
        } else {
            items.filter { $0.title.localizedCaseInsensitiveContains(viewModel.searchText) }
        }
    }

    var sortedItems: [ToDoListItem] {
        viewModel.sortItems(filteredItems)
    }
}

#Preview {
    ToDoListView(userId: "vdw0dsAUbUdfAO3CbKu42tU9O3t1")
}
