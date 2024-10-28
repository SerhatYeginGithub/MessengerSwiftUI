//
//  LoginViewModel.swift
//  MessengerSwiftUI
//
//  Created by serhat on 27.10.2024.
//

import Foundation

final class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    /// Attempts to log the user in using the provided email and password.
    /// - Throws: Any error encountered during the login process.
    /// - Note: Calls the `login` function from `AuthService` to handle authentication.
    func login() async throws {
        try await AuthService.shared.login(withEmail: email, password: password)
    }
}
