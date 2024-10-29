//
//  InboxViewModel.swift
//  MessengerSwiftUI
//
//  Created by serhat on 28.10.2024.
//

import Foundation
import Combine
import Firebase

@MainActor
final class InboxViewModel: ObservableObject {
    @Published var currentUser: User?
    @Published var recentMessages: [Message] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    private let service = InboxService()
    
    /// Initializes the `InboxViewModel`, setting up subscriptions and starting observation of recent messages.
    init() {
        setupSubscriptions()
        service.observeRecentMessages()
    }
    
    
    /// Sets up subscriptions to observe changes in `currentUser` and recent message changes.
    /// Updates `currentUser` from `UserService` and loads initial recent messages when observed.
    private func setupSubscriptions() {
        UserService.shared.$currentUser.sink { [weak self ] currentUserFromUserService in
            self?.currentUser = currentUserFromUserService
        }.store(in: &cancellables)
        
        service.$documentChanges.sink { [weak self] documentChanges in
            self?.loadInitialMessages(fromChanges: documentChanges)
        }.store(in: &cancellables)
    }
    
    
    /// Loads the initial list of recent messages from observed document changes.
    /// - Parameter changes: An array of `DocumentChange` containing recent message updates.
    private func loadInitialMessages(fromChanges changes: [DocumentChange]) {
        var messages = changes.compactMap({ try? $0.document.data(as: Message.self) })
        
        for i in 0 ..< messages.count {
            let message = messages[i]
            UserService.fetchUser(withUid: message.chatPartner) { [weak self] user in
                messages[i].user = user
                self?.recentMessages.append(messages[i])
            }
            
        }
    }
    
}
