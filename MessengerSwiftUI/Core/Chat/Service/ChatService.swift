//
//  ChatService.swift
//  MessengerSwiftUI
//
//  Created by serhat on 28.10.2024.
//

import Foundation
import Firebase
import FirebaseAuth

final class ChatService {
    
    let chatPartner: User
    
    /// Initializes the `ChatService` with a specific chat partner.
    /// - Parameter chatPartner: The user object representing the chat partner.
    init(chatPartner: User) {
        self.chatPartner = chatPartner
    }
    
    
    /// Sends a message to the chat partner by creating a document in both users' message collections.
    /// - Parameter messageText: The text content of the message to send.
    /// - Note: Encodes the message into Firestore format and saves it under both the current user's and the chat partner's message references.
    func sendMessage(_ messageText: String) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let chatPartnerId = chatPartner.id
        
        let currentUserRef = FirestoreConstants.messageCollection.document(currentUid).collection(chatPartnerId).document()
        let chatPartnerRef = FirestoreConstants.messageCollection.document(chatPartnerId).collection(currentUid)
        
        let messageId = currentUserRef.documentID
        
        let message = Message(messageId: messageId, fromId: currentUid, toId: chatPartnerId, messageText: messageText, timestamp: Timestamp())
        
        guard let messageData = try? Firestore.Encoder().encode(message) else { return }
        
        currentUserRef.setData(messageData)
        chatPartnerRef.document(messageId).setData(messageData)
    }
    
    
    /// Observes incoming messages for the chat session between the current user and the chat partner.
    /// - Parameter completion: A closure that returns an array of `Message` objects when new messages are received.
    /// - Note: Listens for added documents in the message collection, processes each new message, and assigns the chat partner's `User` object to messages sent by them.
    func observeMessage (completion: @escaping ([Message]) -> Void ) {
        guard let currentUid = Auth.auth().currentUser?.uid  else { return }
        let chatPartnerId = chatPartner.id
        let query = FirestoreConstants.messageCollection
            .document(currentUid)
            .collection(chatPartnerId)
            .order(by: "timestamp", descending: false)
        
        query.addSnapshotListener { snapshot, _ in
            
            guard let changes = snapshot?.documentChanges.filter({ $0.type == .added }) else { return }
            var messages = changes.compactMap({ try? $0.document.data(as: Message.self) })
            
            for (index, message) in messages.enumerated() where !message.isFromCurrentUser {
                messages[index].user = self.chatPartner
            }
            
            completion(messages)
        }
    }
}
