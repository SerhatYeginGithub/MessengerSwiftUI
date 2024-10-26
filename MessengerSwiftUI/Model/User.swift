//
//  User.swift
//  MessengerSwiftUI
//
//  Created by serhat on 26.10.2024.
//

import Foundation

struct User: Identifiable, Codable, Hashable{
    var id = NSUUID().uuidString
    let fullname: String
    let email: String
    var profileImageUrl: String?
    
}

extension User {
    static let MOCK_USER = User(fullname: "Panda", email: "Panda@gmail.com", profileImageUrl: "panda")
}
