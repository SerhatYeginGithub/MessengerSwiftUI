//
//  ContentViewModel.swift
//  MessengerSwiftUI
//
//  Created by serhat on 27.10.2024.
//

import Foundation
import FirebaseAuth
import Combine

final class ContentViewModel: ObservableObject {
    
    @Published var userSession: FirebaseAuth.User?
    private var cancellables = Set<AnyCancellable>()
    
    /// Initializes the `ContentViewModel` and sets up subscriptions to listen for changes in the user's session.
    init() {
        Task { await setupSubscribers() }
    }
    
    
    /// Sets up a Combine subscription to observe changes in `userSession` from `AuthService`.
    /// Updates `userSession` in `ContentViewModel` when there are changes to `AuthService`'s `userSession`.
    @MainActor private func setupSubscribers() {
        AuthService.shared.$userSession.sink { [weak self] userSessionFromAuthService in
            self?.userSession = userSessionFromAuthService
        }.store(in: &cancellables)
        
    }
}
