//
//  WarehouseManagerView.swift
//  InventoryManager
//
//  Created by Sopulu Chu-Ebunoha on 2026-06-30.
//

import SwiftUI

struct WarehouseManagerView: View {
    @Binding var inventory: [InventoryItem]
    
    // Form Inputs for Adding/Editing
    @State private var itemCode: String = ""
    @State private var itemDescription: String = ""
    @State private var itemPrice: String = ""
    
    // Search Bar State
    @State private var searchQuery: String = ""
    
    // Tracks if we are in "Edit Mode"
    @State private var isEditing: Bool = false
    
    var body: some View {
        ZStack {
            Color.babyPink
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 20) {
                //1. HEADER & GLOBAL STATS
                HStack {
                    VStack(alignment: .leading) {
                        Text("Warehouse Inventory Manager")
                            .font(.custom("AmericanTypewriter", size: 22))
                            .bold()
                        // Dynamically displays total item count (like the first line of the CSV!)
                        Text("Total Stock Items: \(inventory.count)")
                            .font(.custom("AmericanTypewriter", size: 14))
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                }
                Divider()
                
                // 2. MAIN CONTENT AREA (Split Layout)
                HStack(alignment: .top, spacing: 25) {
                    
                    // ==========================================
                    // LEFT SIDE: The Control Panel (Add / Edit)
                    // ==========================================
                    VStack(alignment: .leading, spacing: 15) {
                        Text(isEditing ? "Edit Product Details" : "Register New Product")
                            .font(.custom("AmericanTypewriter", size: 18))
                            .fontWeight(.semibold)
                            .foregroundStyle(isEditing ? .pink : .indigo)
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Product Code")
                                .font(.custom("AmericanTypewriter", size: 10))
                                
                            TextField("e.g., CAPRED", text: $itemCode)
                                .font(.custom("AmericanTypewriter", size: 13))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            // If editing, we disable the code field just like the C# rule!
                                .disabled(isEditing)
                            
                            Text("Description")
                                .font(.custom("AmericanTypewriter", size: 10))
                            TextField("e.g., Baseball cap red, size 30", text: $itemDescription)
                                .font(.custom("AmericanTypewriter", size: 13))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            
                            Text("Price")
                                .font(.custom("AmericanTypewriter", size: 10))
                            TextField("e.g., 40.78", text: $itemPrice)
                                .font(.custom("AmericanTypewriter", size: 13))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        .frame(width: 220)
                        
                        // Action Buttons
                        VStack(spacing: 8) {
                            Button(action: {
                                // Logic for Add or Save Edit goes here
                                processFormSubmit()
                            }) {
                                Text(isEditing ? "Save Adjustments" : "Insert into Inventory")
                                    .font(.custom("AmericanTypewriter", size: 14))
                                    .frame(maxWidth: .infinity)
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(isEditing ? .pink : .indigo)
                            
                            if isEditing {
                                Button("Cancel Selection") {
                                    clearForm()
                                }
                                .buttonStyle(.borderless)
                                .foregroundStyle(.secondary)
                            }
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.05))
                    .cornerRadius(10)
                    
                    // ==========================================
                    // RIGHT SIDE: Live Search & Database List
                    // ==========================================
                    VStack(alignment: .leading, spacing: 10) {
                        
                        //Interactive Search Bar (Option 1 in the C# program)
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundStyle(.secondary)
                            TextField("Search by product code...", text: $searchQuery)
                                .font(.custom("AmericanTypewriter", size: 13))
                                .textFieldStyle(PlainTextFieldStyle())
                        }
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(6)
                        
                        // The Live Table View
                        List {
                            // We filter the list in real-time based on the non-case-sensitive search query!
                            ForEach(inventory.filter {
                                searchQuery.isEmpty || $0.code.lowercased().contains(searchQuery.lowercased())
                            }) { item in
                                
                                // MAGIC UPGRADE: Wrap the row contents inside a NavigationLink to push to details!
                                NavigationLink(destination: ItemDetailView(item: item)) {
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text(item.code)
                                                .font(.custom("AmericanTypewriter", size: 14))
                                                .fontWeight(.semibold)
                                            Text(item.description)
                                                .font(.custom("AmericanTypewriter", size: 11))
                                                .foregroundStyle(.secondary)
                                        }
                                        Spacer()
                                        Text(String(format: "$%.2f", item.price))
                                            .font(.custom("AmericanTypewriter", size: 14))
                                            .fontWeight(.semibold)
                                        
                                        // Edit Button (Option 2 in the C# program)
                                        Button(action: {
                                            startEditing(item)
                                        }) {
                                            Image(systemName: "pencil.circle.fill")
                                                .foregroundStyle(.pink)
                                        }
                                        .buttonStyle(.plain)
                                        .padding(.leading, 10)
                                    }
                                    .padding(.vertical, 4)
                                }
                            }
                        }
                        .frame(minWidth: 400,  minHeight: 300)
                        .listStyle(.inset)
                    }
                }
            }
            .padding(25)
            .frame(minWidth: 750,  minHeight: 480)
        }
    }
    
    // --- UI HELPER FUNCTIONS ---
    
    func startEditing(_ item: InventoryItem) {
        isEditing = true
        itemCode = item.code.uppercased()
        itemDescription = item.description
        itemPrice = String(item.price)
    }
    
    func processFormSubmit() {
        let cleanedPrice = itemPrice.trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: "$", with: "")
        
        guard !itemCode.isEmpty,
              !itemDescription.isEmpty,
              let priceDouble = Double(cleanedPrice) else {
            print("Debug Error: Form submission failed! Code: '\(itemCode)', Desc: '\(itemDescription)', Cleaned Price: '\(cleanedPrice)'")
            return
        }
        
        if isEditing {
            if let index = inventory.firstIndex(where: { $0.code == itemCode.uppercased() }) {
                inventory[index].description = itemDescription
                inventory[index].price = priceDouble
                print("Debug Success: Updated item \(itemCode)")
            } else {
                print("Debug Error: Could not find item code \(itemCode) to edit")
            }
        } else {
            let newItem = InventoryItem(code: itemCode.uppercased(), description: itemDescription, price: priceDouble)
            inventory.append(newItem)
            inventory.sort { $0 .code < $1.code }
            print("Debug Success: Added new item \(itemCode). Total count is now: \(inventory.count)")
        }
        clearForm()
    }
    
    func clearForm() {
        isEditing = false
        itemCode = ""
        itemDescription = ""
        itemPrice = ""
    }
}

#Preview {
    WarehouseManagerView(inventory: .constant([
        InventoryItem(code: "CAPRED", description: "Baseball cap red, size 30", price: 40.78),
        InventoryItem(code: "RAVERSDEN", description: "HEIS T-Shirt Merch US-14", price: 30.55),
        InventoryItem(code: "SOCCERBALL01", description: "Soccer ball (black and white)", price: 65.77)
    ]))
}
