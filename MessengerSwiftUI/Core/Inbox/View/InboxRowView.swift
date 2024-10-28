//
//  InboxRowView.swift
//  MessengerSwiftUI
//
//  Created by serhat on 26.10.2024.
//

import SwiftUI

struct InboxRowView: View {
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            CircularProfileImageView(user: User.MOCK_USER, size: .medium)
            VStack(alignment: .leading, spacing: 4){
                Text("Panda")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text("Some test for now that spans more than one line")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(2)
                    .frame(maxWidth: UIScreen.main.bounds.width - 100, alignment: .leading)
                
            }
            HStack {
                Text("Yesterday")
                Image(systemName: "chevron.right")
            }
            .font(.footnote)
            .foregroundColor(.gray)
        }
        .frame(height: 75)
    }
}

#Preview {
    InboxRowView()
}
