//
//  RegisterView.swift
//  ToDoList
//
//  Created by Aaron Minkov on 7/7/24.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var  viewModel = RegisterViewViewModel()
    
    var body: some View {
        HeaderView(title: "Register", subtitle: "Start organizing todos", angle: -15, background: .orange)

        Form {
            TextField("Full Name", text: $viewModel.name)
            TextField("Email Address", text: $viewModel.email)
                .textInputAutocapitalization(.never)
            SecureField("Password", text: $viewModel.password)

            TLButton(
                title: "Create Account",
                background: .orange
            ) {
                viewModel.register()
            }
        }

        Spacer()
    }
}

#Preview {
    RegisterView()
}
