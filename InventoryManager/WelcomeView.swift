//
//  WelcomeView.swift
//  InventoryManager
//
//  Created by Sopulu Chu-Ebunoha on 2026-06-30.
//

import SwiftUI

struct WelcomeView: View {
    @Binding var inventory: [InventoryItem]
    
    var body: some View {
        VStack(spacing: 25) {
            Spacer()
            
            VStack(spacing: 12) {
                Text("Welcome!")
                    .font(.custom("AmericanTypewriter", size: 200))
                    .foregroundStyle(LinearGradient(colors: [.indigo, .purple, .pink], startPoint: .topLeading, endPoint: .bottomTrailing))
            }
            
            Spacer()
            
            // Bulletproof macOS Navigation Link Layout
            NavigationLink(destination: LaunchDashboardView(inventory: $inventory)) {
                HStack {
                    Text("Continue")
                        .font(.custom("AmericanTypewriter", size: 36))
                        .bold()
                    Image(systemName: "chevron.right")
                }
                .foregroundStyle(.white)
                .padding(.horizontal, 30)
                .padding(.vertical, 12)
                .background(LinearGradient(
                    colors: [.indigo, .purple, .pink],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing))
                .cornerRadius(8)
            }
            // This prevents the Mac window environment from drawing its own ugly default border
            .buttonStyle(.plain)
            
            Spacer()
            Spacer()
                .frame(height: 30)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.babyPink)
    }
}

#Preview {
    WelcomeView(inventory: .constant([
        InventoryItem(code: "CAPRED", description: "Baseball cap red, size 30", price: 40.78),
        InventoryItem(code: "RAVERSDEN", description: "HEIS T-Shirt Merch US-14", price: 30.55),
        InventoryItem(code: "SOCCERBALL01", description: "Soccer ball (black and white)", price: 65.77)
    ]))
}
