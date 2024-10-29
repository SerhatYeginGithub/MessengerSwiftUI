//
//  InboxService.swift
//  MessengerSwiftUI
//
//  Created by serhat on 29.10.2024.
//

import Foundation
import Firebase
import FirebaseAuth

final class InboxService {
    
    @Published var documentChanges = [DocumentChange]()
    
    
    /// Observes changes in the "recent-messages" collection for the current user.
    /// - Note: Only listens to added or modified messages, updating `documentChanges` accordingly.
    func observeRecentMessages() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let query = FirestoreConstants
            .messageCollection
            .document(uid)
            .collection("recent-messages")
            .order(by: "timestamp", descending: true)
        
        query.addSnapshotListener { snapshot, _ in
            guard let changes = snapshot?.documentChanges.filter({ $0.type == .added || $0.type == .modified }) else { return }
            self.documentChanges = changes
            
        }
    }
}
