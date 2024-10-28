//
//  AuthService.swift
//  MessengerSwiftUI
//
//  Created by serhat on 27.10.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

@MainActor
final class AuthService {
    @Published var userSession: FirebaseAuth.User?
    static let shared =  AuthService()
    
    /// Private initializer to enforce singleton pattern. Sets the initial user session state based on Firebase's current user session.
    private init() {
        self.userSession = Auth.auth().currentUser
        Task { try await UserService.shared.fetchCurrentUser() }
    }
    
    /// Logs the user in with the provided email and password credentials asynchronously.
    /// - Parameters:
    ///   - email: User's email address.
    ///   - password: User's password.
    /// - Throws: Any error encountered during the login process.
    /// - Note: Sets `userSession` to the authenticated user if login succeeds.
    func login(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
        } catch {
            print("DEBUG: Failed to sign In with error: \(error.localizedDescription) ")
        }
    }
    
    
    /// Creates a new user account with the provided email and password asynchronously.
    /// - Parameters:
    ///   - email: User's email address.
    ///   - password: User's password.
    ///   - fullname: User's full name (currently unused but included for future user data handling).
    /// - Throws: Any error encountered during the user creation process.
    /// - Note: Sets `userSession` to the newly created user if the process succeeds.
    func createUser(withEmail email: String, password: String, fullname: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            try await uploadUserData(email: email, fullname: fullname, id: result.user.uid)
        } catch {
            print("DEBUG: Failed to create with error: \(error.localizedDescription) ")
        }
    }
    
    
    /// Signs the user out, ending the current session. If successful, sets `userSession` to nil.
    /// - Note: If an error occurs during sign-out, it is silently ignored.
    func signOut() {
        guard let _ = try? Auth.auth().signOut() else { return }
        self.userSession = nil
    }
    
    
    /// Uploads user data to Firestore after user registration.
    /// - Parameters:
    ///   - email: User's email address.
    ///   - fullname: User's full name.
    ///   - id: The user’s unique identifier (UID).
    /// - Throws: Any error encountered during the data upload process.
    /// - Note: Encodes the user data and stores it in the "users" collection on Firestore.
    private func uploadUserData(email: String, fullname: String, id: String) async throws {
        let user = User(uid: id, fullname: fullname, email: email, profileImageUrl: nil)
        guard let encodedUser = try? Firestore.Encoder().encode(user) else { return }
        try await Firestore.firestore().collection("users").document(id).setData(encodedUser)
    }
}
