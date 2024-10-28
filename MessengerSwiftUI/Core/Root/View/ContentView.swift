//
//  ContentView.swift
//  MessengerSwiftUI
//
//  Created by serhat on 26.10.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var vm = ContentViewModel()
    @State private var isPresented: Bool = false
    var body: some View {
        Group {
            if isPresented {
                if vm.userSession != nil {
                    InboxView()
                } else {
                    LoginView()
                }
            }
        }
        .onAppear() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                isPresented = true
            }
        }
    }
        
}

#Preview {
    ContentView()
}
