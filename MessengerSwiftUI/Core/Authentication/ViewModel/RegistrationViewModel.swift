//
//  RegistrationViewModel.swift
//  MessengerSwiftUI
//
//  Created by serhat on 27.10.2024.
//

import Foundation

final class RegistrationViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    @Published var fullname = ""
    
    
    /// Initiates the user registration process by calling `createUser` in `AuthService`.
    /// - Throws: Any error that occurs during the registration process.
    /// - Note: This function uses the provided email, password, and full name to create a new user in the app's authentication system.
    func createUser() async throws {
        try await  AuthService.shared.createUser(withEmail: email, password: password, fullname: fullname)
    }
}
