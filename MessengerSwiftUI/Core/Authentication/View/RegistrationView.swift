//
//  RegistrationView.swift
//  MessengerSwiftUI
//
//  Created by serhat on 26.10.2024.
//

import SwiftUI

struct RegistrationView: View {
    @Environment(\.dismiss) private var dismiss
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
                TextField("Enter your email", text: .constant(""))
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal, 12)
                TextField("Enter your full name", text: .constant(""))
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal, 12)
                SecureField("Enter your password", text: .constant(""))
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal, 12)
                
            }
            
        
            // Register Button
            Button {
                print("DEBUG: REGISTER BUTTON TAPPED.")
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
