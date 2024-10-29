//
//  ActiveNowView.swift
//  MessengerSwiftUI
//
//  Created by serhat on 26.10.2024.
//

import SwiftUI

struct ActiveNowView: View {
    @StateObject private var vm = ActiveNowViewModel()
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false ) {
            HStack(spacing: 32){
                ForEach(vm.users) { user in
                    VStack {
                        
                        NavigationLink(value: Route.chat(user)) {
                            ZStack(alignment: .bottomTrailing){
                                CircularProfileImageView(user: user, size: .medium)
                                ZStack {
                                    Circle()
                                        .foregroundColor(Color(.systemGray5))
                                        .frame(width: 18, height: 18)
                                    
                                    Circle()
                                        .foregroundColor(Color(.systemGreen))
                                        .frame(width: 12, height: 12)
                                }
                                
                                
                            }
                        }
                        Text(user.firstname)
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
