//
//  SplashView.swift
//  InventoryManager
//
//  Created by Sopulu Chu-Ebunoha on 2026-06-30.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            // A rich, colorful mesh gradient background
            LinearGradient(colors: [.indigo, .purple, .pink],
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack {
                // Your app icon (using a premium system icon style as a placeholder)
                Image(systemName: "shippingbox")
                    .font(.system(size: 200))
                    .foregroundStyle(.babyPink)
                    .shadow(radius: 10)
                Text("Warehouse Inventory Manager")
                    .font(.custom("AmericanTypewriter", size: 50))
                    .foregroundStyle(.babyPink)
                
            }
        }
        .frame(minWidth: 750, minHeight: 480)
    }
}

#Preview {
    SplashView()
}
