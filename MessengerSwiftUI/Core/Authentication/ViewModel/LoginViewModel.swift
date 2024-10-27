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
    
    func login() async throws {
        try await AuthService.shared.login(withEmail: email, password: password)
    }
}
