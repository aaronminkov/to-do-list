//
//  ProfileView.swift
//  ToDoList
//
//  Created by Aaron Minkov on 7/7/24.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewViewModel()

    var body: some View {
        NavigationView {
            VStack {

            }
            .navigationTitle("Profile")
        }
    }
}

#Preview {
    ProfileView()
}
