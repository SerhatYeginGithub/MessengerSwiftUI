//
//  InboxViewModel.swift
//  MessengerSwiftUI
//
//  Created by serhat on 28.10.2024.
//

import Foundation
import Combine

final class InboxViewModel: ObservableObject {
    @Published var currentUser: User?
    
    private var cancellables = Set<AnyCancellable>()
    
    
    /// Initializes the `InboxViewModel` and sets up subscriptions to listen for changes in the `currentUser`.
    init() {
        setupSubscriptions()
    }
    
    /// Sets up a Combine subscription to observe changes in `currentUser` from `UserService`.
    /// Updates `currentUser` in `InboxViewModel` whenever there is a change in `UserService`'s `currentUser`.
    private func setupSubscriptions() {
        UserService.shared.$currentUser.sink { [weak self ] currentUserFromUserService in
            self?.currentUser = currentUserFromUserService
        }.store(in: &cancellables)
    }
    
}
