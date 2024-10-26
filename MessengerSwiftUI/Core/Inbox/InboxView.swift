//
//  InboxView.swift
//  MessengerSwiftUI
//
//  Created by serhat on 26.10.2024.
//

import SwiftUI

struct InboxView: View {
    @State private var showMessageView = false
    @State private var user = User.MOCK_USER
    var body: some View {
        NavigationStack {
            ScrollView {
                ActiveNowView()
                List{
                    ForEach(0..<10) { _ in
                        InboxRowView()
                    }
                    
                }
                .listStyle(.plain)
                .frame(height: UIScreen.main.bounds.height - 120)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) { toolbarItemPerson }
                
                ToolbarItem(placement: .navigationBarTrailing) { toolBarItemButton }
            }
            .fullScreenCover(isPresented: $showMessageView) {
                NewMessageView()
            } 
        }
    }
}

#Preview {
    InboxView()
}


private extension InboxView {
    
    var toolbarItemPerson: some View {
        HStack {
            NavigationLink(destination: ProfileView(user: user), label: {
                CircularProfileImageView(user: user, size: .xSmall)
            })
            Text("Chats")
                .font(.title)
                .fontWeight(.semibold)
        }
    }
    
    var toolBarItemButton: some View {
        Button { showMessageView.toggle() } label: {
            Image(systemName: "square.and.pencil.circle.fill")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundStyle(.black, Color(.systemGray5) )
        }
    }
    
    
}
