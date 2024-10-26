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
    var body: some View {
        NavigationStack {
            ScrollView {
                Text("CONTACTS")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding()
                
                ForEach(0..<10) { _ in
                    LazyVStack {
                        HStack {
                            CircularProfileImageView(user: User.MOCK_USER, size: .small)
                            Text("Serhat")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Spacer()
                        }
                        .padding(.leading)
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
    NewMessageView()
}
