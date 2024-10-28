//
//  NewMessageView.swift
//  MessengerSwiftUI
//
//  Created by serhat on 26.10.2024.
//

import SwiftUI

struct NewMessageView: View {
    @State private var searchText = ""
    @Environment(\.dismiss) private var dismiss
    @StateObject private var vm = NewMessageViewModel()
    @Binding var selectedUser: User?
    var body: some View {
        NavigationStack {
            ScrollView {
                Text("CONTACTS")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding()
                
                ForEach(vm.users) { user in
                    LazyVStack {
                        HStack {
                            CircularProfileImageView(user: user, size: .small)
                            Text(user.fullname)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Spacer()
                        }
                        .padding(.leading)
                        .onTapGesture {
                            selectedUser = user
                            dismiss()
                        }
                        Divider()
                            
                    }
                }
            }
            .navigationTitle("New Message")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                    .foregroundColor(.black)
                }
                
            }
        }
        .searchable(text: $searchText, prompt: Text("To: "))
       
      
    }
}

#Preview {
    NewMessageView(selectedUser: .constant(User.MOCK_USER))
}
