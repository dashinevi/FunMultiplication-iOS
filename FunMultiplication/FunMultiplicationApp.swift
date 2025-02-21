//
//  FunMultiplicationApp.swift
//  FunMultiplication
//
//  Created by Diana Dashinevich on 21/02/2025.
//

import SwiftUI

@main
struct FunMultiplicationApp: App {
    @StateObject var viewModel = MultiplicationViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
