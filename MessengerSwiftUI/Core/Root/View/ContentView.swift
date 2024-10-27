//
//  ContentView.swift
//  MessengerSwiftUI
//
//  Created by serhat on 26.10.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var vm = ContentViewModel()
    var body: some View {
        Group {
            if let _ = vm.userSession {
                InboxView()
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    ContentView()
}
