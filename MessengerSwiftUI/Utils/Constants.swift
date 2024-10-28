//
//  Constants.swift
//  MessengerSwiftUI
//
//  Created by serhat on 29.10.2024.
//

import Foundation
import Firebase

struct FirestoreConstants {
    
    static let messageCollection = Firestore.firestore().collection("messages")
    static let userCollection = Firestore.firestore().collection("users")
}
