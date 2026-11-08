//
//  LaunchDashboardView.swift
//  InventoryManager
//
//  Created by Sopulu Chu-Ebunoha on 2026-06-30.
//

import SwiftUI

struct LaunchDashboardView: View {
    @Binding var inventory: [InventoryItem]
    
    var body: some View {
        VStack(spacing: 25) {
            Image(systemName: "lock.shield.fill")
                .font(.system(size: 200))
                .foregroundColor(.pink)
            
            VStack(spacing: 8) {
                Text("Central Logistics Terminal")
                    .font(.custom("AmericanTypewriter", size: 50))
                    .bold()
                Text("Secure Node Access Authorized")
                    .font(.custom("AmericanTypewriter", size: 30))
                    .foregroundColor(.secondary)
            }
            
            NavigationLink(destination: WarehouseManagerView(inventory: $inventory)) {
                Text("Launch Warehouse Operations")
                    .font(.custom("AmericanTypewriter", size: 34))
                    .bold()
                    .frame(width: 540, height: 60)
            }
            .buttonStyle(.borderedProminent)
            .tint(.pink)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.babyPink)
    }
}

#Preview {
    LaunchDashboardView(inventory: .constant([
        InventoryItem(code: "CAPRED", description: "Baseball cap red, size 30", price: 40.78),
        InventoryItem(code: "RAVERSDEN", description: "HEIS T-Shirt Merch US-14", price: 30.55),
        InventoryItem(code: "SOCCERBALL01", description: "Soccer ball (black and white)", price: 65.77)
    ]))
}
