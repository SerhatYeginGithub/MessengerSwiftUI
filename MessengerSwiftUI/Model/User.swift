//
//  User.swift
//  MessengerSwiftUI
//
//  Created by serhat on 26.10.2024.
//

import Foundation
import FirebaseFirestore

struct User: Identifiable, Codable, Hashable{
    @DocumentID var uid: String?
    let fullname: String
    let email: String
    var profileImageUrl: String?
    
    var id: String { uid ?? NSUUID().uuidString }
    
}

extension User {
    static let MOCK_USER = User(fullname: "Panda", email: "Panda@gmail.com", profileImageUrl: "panda")
}
