//
//  ChatViewModel.swift
//  MessengerSwiftUI
//
//  Created by serhat on 28.10.2024.
//

import Foundation

final class ChatViewModel: ObservableObject {
    @Published var messageText = ""
    @Published var messages: [Message] = []
    
    let chatService: ChatService
    
    
    /// Initializes `ChatViewModel` with a chat partner and sets up message observation.
    /// - Parameter user: The `User` object representing the chat partner.
    init(user: User) {
        self.chatService = ChatService(chatPartner: user)
        observeMessages()
    }
    
    
    /// Sends the current `messageText` as a message if it is not empty.
    /// - Note: The `messageText` is cleared after being sent.
    func sendMessage() {
        guard !messageText.isEmpty else { return }
        chatService.sendMessage(messageText)
    }
    
    
    /// Observes messages in the chat by setting up a listener in `ChatService`.
    /// - Note: Appends newly received messages to the `messages` array.
    func observeMessages() {
        chatService.observeMessage() { [weak self] messages in
            self?.messages.append(contentsOf: messages)
        }
    }
}
