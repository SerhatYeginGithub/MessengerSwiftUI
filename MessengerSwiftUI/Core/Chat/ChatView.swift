//
//  ChatView.swift
//  MessengerSwiftUI
//
//  Created by serhat on 26.10.2024.
//

import SwiftUI

struct ChatView: View {
    @State private var messageText: String = ""
    
    var body: some View {
        VStack {
            ScrollView {
                // Header
                LazyVStack {
                    CircularProfileImageView(user: User.MOCK_USER, size: .xLarge)
                    VStack(spacing: 4) {
                        Text("Panda")
                            .font(.title3)
                            .fontWeight(.semibold)
                        Text("Messenger")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                    
                }
                // Messages
                ForEach(0...25, id: \.self) { _ in
                    ChatMessageCell(isFromCurrenUser: Bool.random())
                }
         
            }
            // Message Input View
            Spacer()
            ZStack(alignment: .trailing){
                TextField("Message...", text: $messageText ,axis: .vertical)
                    .padding(12)
                    .padding(.trailing, 50)
                    .background(Color(.systemGroupedBackground))
                    .clipShape(Capsule())
                    .font(.subheadline)
                
                Button("Send") {
                    print("DEBUG: SEND MESSAGE")
                }
                .fontWeight(.semibold)
                .padding(.horizontal)
            }
            .padding()
        }
    }
}

#Preview {
    ChatView()
}
