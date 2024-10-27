//
//  AuthService.swift
//  MessengerSwiftUI
//
//  Created by serhat on 27.10.2024.
//

import Foundation
import FirebaseAuth

final class AuthService {
    @Published var userSession: FirebaseAuth.User?
    static let shared =  AuthService()
    
    private init() {
        self.userSession = Auth.auth().currentUser
    }
    
    func login(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
        } catch {
            print("DEBUG: Failed to sign In with error: \(error.localizedDescription) ")
        }
    }
    
    func createUser(withEmail email: String, password: String, fullname: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            print("DEBUG: Create user \(result.user.uid)")
        } catch {
            print("DEBUG: Failed to create with error: \(error.localizedDescription) ")
        }
    }
    
    
    func signOut() {
        guard let _ = try? Auth.auth().signOut() else { return }
        
        self.userSession = nil
    }
}
