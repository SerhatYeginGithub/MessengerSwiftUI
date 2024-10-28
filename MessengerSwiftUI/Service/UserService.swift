//
//  UserService.swift
//  MessengerSwiftUI
//
//  Created by serhat on 28.10.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class UserService {
    @Published var currentUser: User?
    
    static let shared = UserService()
    
    private init() {}
    
    /// Fetches the current user's data from Firestore asynchronously.
    /// - Throws: Any error encountered during the data retrieval process.
    /// - Note: If the user is authenticated, retrieves the document for the current user's ID from the "users" collection,
    ///         decodes it into a `User` object, and assigns it to `currentUser`.
    func fetchCurrentUser() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
        let user = try snapshot.data(as: User.self)
        self.currentUser = user
        print("DEBUG: Current user in service is \(String(describing: currentUser))")
    }
}
