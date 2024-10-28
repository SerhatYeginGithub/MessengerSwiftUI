//
//  NewMessageViewModel.swift
//  MessengerSwiftUI
//
//  Created by serhat on 28.10.2024.
//

import Foundation
import FirebaseAuth

@MainActor
final class NewMessageViewModel: ObservableObject {
    @Published var users: [User] = []
    
    /// Initializes `NewMessageViewModel` and triggers the fetch operation for users.
    init() {
        Task { try await fetchUsers() }
    }
    
    
    /// Asynchronously fetches all users from `UserService`, excluding the current user.
    /// - Throws: Any error encountered during data fetching from Firestore.
    func fetchUsers() async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let users = try await UserService.fetchAllUsers()
        self.users = users.filter({ $0.id != currentUid })
    }
    
}
