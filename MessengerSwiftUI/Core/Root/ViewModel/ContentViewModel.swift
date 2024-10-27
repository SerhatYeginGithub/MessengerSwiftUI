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
    
    init() {
        setupSubscribers()
    }
    
    private func setupSubscribers() {
        AuthService.shared.$userSession.sink { [weak self] userSessionFromAuthService in
            self?.userSession = userSessionFromAuthService
        }.store(in: &cancellables)

    }
}
