//
//  ContentView.swift
//  FunMultiplication
//
//  Created by Diana Dashinevich on 21/02/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var activeTab: Tab = .home
    @StateObject private var viewModel = MultiplicationViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                switch activeTab {
                case .home:
                    HomeView(viewModel: viewModel)
                case .settings:
                    SettingsView(viewModel: viewModel)
                }
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    TabBarView(selectedTab: $activeTab)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
