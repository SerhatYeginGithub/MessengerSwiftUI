//
//  ChatView.swift
//  MessengerSwiftUI
//
//  Created by serhat on 26.10.2024.
//

import SwiftUI

struct ChatView: View {
    @StateObject private var vm: ChatViewModel
    let user: User
    
    init(user: User) {
        self.user = user
        self._vm = StateObject(wrappedValue: ChatViewModel(user: user))
    }
    var body: some View {
        VStack {
            ScrollView {
                // Header
                LazyVStack {
                    CircularProfileImageView(user: user, size: .xLarge)
                    VStack(spacing: 4) {
                        Text(user.fullname)
                            .font(.title3)
                            .fontWeight(.semibold)
                        Text("Messenger")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                    
                }
                // Messages
                ForEach(vm.messages) { message in
                    ChatMessageCell(message: message)
                }
         
            }
            // Message Input View
            Spacer()
            ZStack(alignment: .trailing){
                TextField("Message...", text: $vm.messageText ,axis: .vertical)
                    .padding(12)
                    .padding(.trailing, 50)
                    .background(Color(.systemGroupedBackground))
                    .clipShape(Capsule())
                    .font(.subheadline)
                
                Button("Send") {
                    vm.sendMessage()
                    vm.messageText = ""
                }
                .fontWeight(.semibold)
                .padding(.horizontal)
            }
            .padding()
        }
    }
}

#Preview {
    ChatView(user: .MOCK_USER)
}
