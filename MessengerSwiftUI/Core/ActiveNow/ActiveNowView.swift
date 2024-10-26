//
//  ActiveNowView.swift
//  MessengerSwiftUI
//
//  Created by serhat on 26.10.2024.
//

import SwiftUI

struct ActiveNowView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false ) {
            HStack(spacing: 32){
                ForEach(0..<10) { _ in
                    VStack {
                        ZStack(alignment: .bottomTrailing){
                            CircularProfileImageView(user: User.MOCK_USER, size: .medium)
                            ZStack {
                                Circle()
                                    .foregroundColor(Color(.systemGray5))
                                    .frame(width: 18, height: 18)
                                
                                Circle()
                                    .foregroundColor(Color(.systemGreen))
                                    .frame(width: 12, height: 12)
                            }
                            
                           
                        }
                        Text("Panda")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding()
        }
        .frame(height: 110)
    }
}

#Preview {
    ActiveNowView()
}