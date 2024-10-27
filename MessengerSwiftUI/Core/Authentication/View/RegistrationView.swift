//
//  RegistrationView.swift
//  MessengerSwiftUI
//
//  Created by serhat on 26.10.2024.
//

import SwiftUI

struct RegistrationView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var vm = RegistrationViewModel()
    var body: some View {
        NavigationStack {
            
            Spacer()
            
            // Logo Image
         
            Image("messenger-logo")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .padding()
            
            // TextFields
            
            VStack(spacing: 12) {
                TextField("Enter your email", text: $vm.email)
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal, 12)
                TextField("Enter your full name", text: $vm.fullname)
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal, 12)
                SecureField("Enter your password", text: $vm.password)
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal, 12)
                
            }
            
        
            // Register Button
            Button {
                Task { try await vm.createUser() }
            } label: {
                Text("Sign Up")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 25, height: 44)
                    .background(Color(.systemBlue))
                    .cornerRadius(10)
            }
            .padding(.top, 12)
            
            Spacer()
            
            // Sign In Link
            Divider()
            
            Button {
               dismiss()
            } label: {
                HStack(spacing: 3){
                    Text("Already have an account?")
                    Text("Sign In")
                        .fontWeight(.semibold)
                }
                .font(.footnote)
            }
            
            .padding(.vertical)
            
            
        }
    }
}

#Preview {
    RegistrationView()
}
