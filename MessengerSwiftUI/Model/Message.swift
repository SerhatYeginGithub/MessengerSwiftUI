//
//  Message.swift
//  MessengerSwiftUI
//
//  Created by serhat on 28.10.2024.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

struct Message: Identifiable, Codable, Hashable {
    @DocumentID var messageId: String?
    let fromId: String
    let toId: String
    let messageText: String
    let timestamp: Timestamp
    
    var user: User?
    
    var id: String { messageId ?? NSUUID().uuidString }
    
    var chatPartner: String { fromId == Auth.auth().currentUser?.uid ? toId : fromId }
    
    var isFromCurrentUser: Bool { fromId == Auth.auth().currentUser?.uid }
    
    var timestampString: String {
        return timestamp.dateValue().timestampString()
    }
}

