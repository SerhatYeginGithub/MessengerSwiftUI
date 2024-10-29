//
//  UserService.swift
//  MessengerSwiftUI
//
//  Created by serhat on 28.10.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

@MainActor
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
        let snapshot = try await FirestoreConstants.userCollection.document(uid).getDocument()
        let user = try snapshot.data(as: User.self)
        self.currentUser = user
        print("DEBUG: Current user in service is \(String(describing: currentUser))")
    }
    
    
    /// Fetches all users from the Firestore database asynchronously.
    /// - Returns: An array of `User` objects representing all users in the Firestore `userCollection`.
    /// - Throws: An error if the Firestore fetch operation fails.
    /// - Note: This function uses `compactMap` to filter out any documents that cannot be decoded into `User` objects.
    static func fetchAllUsers(limit: Int) async throws -> [User] {
        let query = FirestoreConstants.userCollection.limit(to: limit)
        let snapshot = try await query.getDocuments()
        return snapshot.documents.compactMap({ try? $0.data(as: User.self) })
    }
    
    
    /// Fetches a `User` object from Firestore using the provided user ID (uid).
    /// - Parameters:
    ///   - uid: The unique identifier of the user to fetch.
    ///   - completion: A closure that takes a `User` object and is called with the fetched user data if successful.
    /// - Note: If fetching the user data fails, the completion handler is not called.
    static func fetchUser(withUid uid: String, completion: @escaping (User)-> Void ) {
        FirestoreConstants.userCollection.document(uid).getDocument { snapshot, _ in
            guard let user = try? snapshot?.data(as: User.self) else { return }
            completion(user)
        }
    }
}
