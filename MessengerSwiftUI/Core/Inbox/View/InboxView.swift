//
//  InboxView.swift
//  MessengerSwiftUI
//
//  Created by serhat on 26.10.2024.
//

import SwiftUI

struct InboxView: View {
    @State private var showMessageView = false
    @StateObject private var vm = InboxViewModel()
    @State private var selectedUser: User?
    @State private var showChat = false
    private var user: User? { vm .currentUser }
    
    var body: some View {
        NavigationStack {
            
            List{
                ActiveNowView()
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets())
                    .padding(.vertical)
                    .padding(.horizontal, 4)
                
                ForEach(vm.recentMessages) { message in
                    ZStack {
                        NavigationLink(value: message) {
                            EmptyView()
                        }.opacity(0.0)
                        
                        InboxRowView(message: message)
                    }
                    
                }
                
            }
            .listStyle(.plain)
            .frame(height: UIScreen.main.bounds.height - 120)
            .navigationDestination(for: Route.self, destination: { route in
                switch route {
                case .profile(let user):
                    ProfileView(user: user)
                case .chat(let user):
                    ChatView(user: user)
                }
            })
            .navigationDestination(isPresented: $showChat) {
                if let user = selectedUser {
                    ChatView(user: user)
                }
                
            }
            .navigationDestination(for: Message.self, destination: { message in
                if let user = message.user {
                    ChatView(user: user)
                }
            })
            
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) { toolbarItemPerson }
                
                ToolbarItem(placement: .navigationBarTrailing) { toolBarItemButton }
            }
            
            .fullScreenCover(isPresented: $showMessageView) {
                NewMessageView(selectedUser: $selectedUser)
            }
            .onChange(of: selectedUser) { newValue in
                showChat = newValue != nil
            }
            .navigationTitle("Chat")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}



private extension InboxView {
    
    @ViewBuilder
    var toolbarItemPerson: some View {
       
            if let user = user {
                NavigationLink(value: Route.profile(user)){
                    CircularProfileImageView(user: user, size: .xSmall)
                }
            } else {
                CircularProfileImageView(user: nil, size: .xSmall)
            }
          
       
    }
    
    var toolBarItemButton: some View {
        Button {
            showMessageView.toggle()
            selectedUser = nil
        } label: {
            Image(systemName: "square.and.pencil.circle.fill")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundStyle(.black, Color(.systemGray5) )
        }
    }
    
    
}
