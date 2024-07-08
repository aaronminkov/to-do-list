//
//  LoginView.swift
//  ToDoList
//
//  Created by Aaron Minkov on 7/7/24.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewViewModel()

    var body: some View {
        NavigationView {
            VStack {
                // Header
                HeaderView(title: "To Do List", subtitle: "Get things done", angle: 15, background: .pink)

                // Login Form
                Form {
                    TextField("Email Address", text: $viewModel.email)
                        .textFieldStyle(.automatic)
                        .textInputAutocapitalization(.never)
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(.automatic)
                    
                    TLButton(
                        title: "Login",
                        background: .pink
                    ) {
                        viewModel.login()
                    }
                    
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundColor(.red)
                    }
                }
                
                // Create Acount
                VStack {
                    Text("New around here?")
                    NavigationLink("Create An Account", destination: RegisterView())
                }
                Spacer()
            }
        }
    }
}

#Preview {
    LoginView()
}
