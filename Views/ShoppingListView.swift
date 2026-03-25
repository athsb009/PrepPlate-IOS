//
//  ShoppingListView.swift
//  PrepPlate
//
//  Created by Atharva Bibave on 10/27/25.
//

import SwiftUI
import SwiftData

struct ShoppingListView: View {
 
    @Environment(\.modelContext) private var modelContext
    
    @Query(sort: \ShoppingItem.createdAt, order: .forward)
    private var items: [ShoppingItem]
    
    var body: some View {
        if items.isEmpty {
            VStack {
                Image(systemName: "cart")
                    .font(.system(size: 60))
                    .foregroundColor(.gray.opacity(0.6))
                Text("Your list is empty")
                    .font(.title3)
                    .fontWeight(.medium)
                    .padding(.top, 10)
                Text("Tap 'Add Ingredients' on a recipe to get started.")
                    .font(.callout)
                    .foregroundColor(.gray)
            }
            .navigationTitle("Shopping List")
        } else {
            List {
                ForEach(items) { item in
                    ShoppingItemRow(item: item)
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("Shopping List")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Clear All", action: clearList)
                }
            }
        }
    }
    
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
    
    private func clearList() {
        withAnimation {
            for item in items {
                modelContext.delete(item)
            }
        }
    }
}

struct ShoppingItemRow: View {
    @Bindable var item: ShoppingItem
    
    var body: some View {
        HStack {
            Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                .foregroundColor(item.isCompleted ? .green : .gray)
                .font(.title2)
                .onTapGesture {
                    withAnimation {
                        item.isCompleted.toggle()
                    }
                }
            
            VStack(alignment: .leading) {
                Text(item.originalString)
                    .font(.headline)
                    .strikethrough(item.isCompleted, color: .gray)
                    .foregroundColor(item.isCompleted ? .gray : .primary)
                Text(item.name)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding(.leading, 10)
        }
    }
}


