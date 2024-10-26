//
//  LoginView.swift
//  MessengerSwiftUI
//
//  Created by serhat on 26.10.2024.
//

import SwiftUI

struct LoginView: View {
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
                SecureField("Enter your password", text: .constant(""))
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal, 12)
                
            }
            
            // Forgot password
            Button {
                print("DEBUG: Forgot password.")
            } label: {
                Text("Forgot password?")
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .padding(.top)
                    .padding(.trailing, 28)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            
            // Login Button
            Button {
                print("DEBUG: LOGIN.")
            } label: {
                Text("Login")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 25, height: 44)
                    .background(Color(.systemBlue))
                    .cornerRadius(10)
            }
            // Facebook Login
            HStack {
                Rectangle()
                    .frame(height: 0.5)
                Text("OR")
                Rectangle()
                    .frame(height: 0.5)
            }
            .foregroundColor(.gray)
            .frame(width: UIScreen.main.bounds.width - 25)
            .padding(.top, 8)
            HStack {
                Image("facebook-logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                Text("Continue with Facebook")
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundColor(Color(.systemBlue))
                
            }
            .padding(.top, 8)
            
            Spacer()
            
            // Signup link
            Divider()
            
            NavigationLink {
                RegistrationView()
                    .navigationBarBackButtonHidden()
            } label: {
                
                HStack(spacing: 3){
                    Text("Don't have an account ?")
                    Text("Sign Up")
                        .fontWeight(.semibold)
                    
                }
                .font(.footnote)
            
            }
            .padding(.vertical)
            
            
        }
    }
}

#Preview {
    LoginView()
}
