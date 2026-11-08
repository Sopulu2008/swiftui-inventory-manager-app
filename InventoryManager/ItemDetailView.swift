//
//  ItemDetailView.swift
//  InventoryManager
//
//  Created by Sopulu Chu-Ebunoha on 2026-06-30.
//

import SwiftUI

struct ItemDetailView: View {
    let item: InventoryItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading, spacing: 4) {
                Text("PRODUCT REGISTRY")
                    .font(.custom("AmericanTypewriter", size: 30))
                    .foregroundColor(.indigo)
                Text(item.code)
                    .font(.custom("AmericanTypewriter", size: 60))
                    .bold()
            }
            
            Divider()
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Description")
                    .font(.custom("AmericanTypewriter", size: 34))
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)
                Text(item.description)
                    .font(.custom("AmericanTypewriter", size: 35))
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Financial Asset Valuation")
                    .font(.custom("AmericanTypewriter", size: 34))
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)
                Text(String(format: "$%.2f CAD", item.price))
                    .font(.custom("AmericanTypewriter", size: 50))
                    .fontWeight(.semibold)
                    .foregroundColor(.purple)
            }
            
            Spacer()
        }
        .padding(40)
        .frame(minWidth: 750, minHeight: 480)
        .background(Color.babyPink)
    }
}

#Preview {
    ItemDetailView(item: InventoryItem(
        code: "CAPRED",
        description: "Baseball cap red, size 30",
        price: 40.78
    ))
}
