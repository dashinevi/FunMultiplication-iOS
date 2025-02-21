//
//  TabBarView.swift
//  FunMultiplication
//
//  Created by Diana Dashinevich on 21/02/2025.
//
import SwiftUI

enum Tab: String, CaseIterable, Identifiable {
    case home
    case settings
    
    var id: String { rawValue }
    
    var title: String {
        switch self {
        case .home: return "Home"
        case .settings: return "Settings"
        }
    }
    
    var icon: String {
        switch self {
        case .home: return "house"
        case .settings: return "gearshape"
        }
    }
}

struct TabBarView: View {
    @Binding var selectedTab: Tab
    
    var body: some View {
        HStack {
            Spacer()
            Button(Tab.home.title, systemImage: Tab.home.icon) {
                withAnimation {
                    selectedTab = .home
                }
            }
            .tint(selectedTab == .home ? .primary : .secondary)

            Spacer()
            Button(Tab.settings.title, systemImage: Tab.settings.icon) {
                withAnimation {
                    selectedTab = .settings
                }
            }
            .tint(selectedTab == .settings ? .primary : .secondary)
            Spacer()
        }
    }
}
