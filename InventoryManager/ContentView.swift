//
//  ContentView.swift
//  InventoryManager
//
//  Created by Sopulu Chu-Ebunoha on 2026-06-29.
//

import SwiftUI

// This represents one line of the CSV data file
struct InventoryItem: Identifiable {
    let id = UUID() // Required by SwiftUI to list items cleanly
    var code: String
    var description: String
    var price: Double
}

struct ContentView: View {
    // 1. Master Database Array
    @State private var inventory: [InventoryItem] = [
        InventoryItem(code: "CAPRED", description: "Baseball cap red, size 30", price: 40.78),
        InventoryItem(code: "RAVERSDEN", description: "HEIS T-Shirt Merch US-14", price: 30.55),
        InventoryItem(code: "SOCCERBALL01", description: "Soccer ball (black and white)", price: 65.77)
    ]
    
    // 2. Navigation State Tracking
    @State private var currentScreen: String = "splash"
    
    var body: some View {
        ZStack {
            switch currentScreen {
            case "splash":
                SplashView()
                    .onAppear {
                        // Keep splash screen for 2 seconds, then transition to welcome
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            withAnimation(.easeInOut(duration: 3.0)) {
                                currentScreen = "welcome"
                            }
                        }
                    }
                    
            case "welcome":
                // Wrap the rest of the app experience inside the root NavigationStack
                NavigationStack {
                    WelcomeView(inventory: $inventory)
                }
                
            default:
                EmptyView()
            }
        }
        // FIXED: Applying the frame size constraints to the absolute root layout window
        // matches your custom Warehouse View space precisely so nothing ever cuts off!
        .frame(minWidth: 750, minHeight: 480)
    }
}

#Preview {
    ContentView()
}

#Preview {
    ContentView()
}
