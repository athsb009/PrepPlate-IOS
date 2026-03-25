//
//  CookbookView.swift
//  PrepPlate
//
//  Created by Atharva Bibave on 10/27/25.
//


import SwiftUI
import SwiftData

struct CookbookView: View {
    @Query(sort: \SavedRecipe.savedAt, order: .reverse)
    private var savedRecipes: [SavedRecipe]
    
    var body: some View {
        if savedRecipes.isEmpty {
            VStack {
                Image(systemName: "book")
                    .font(.system(size: 60))
                    .foregroundColor(.gray.opacity(0.6))
                Text("Your cookbook is empty")
                    .font(.title3)
                    .fontWeight(.medium)
                    .padding(.top, 10)
                Text("Tap the 'Save' button on a recipe to add it here.")
                    .font(.callout)
                    .foregroundColor(.gray)
            }
            .navigationTitle("My Cookbook")
        } else {
            List(savedRecipes) { recipe in
                NavigationLink(destination: RecipeDetailView(recipeID: recipe.id)) {
                    RecipeCard(recipe: Recipe(id: recipe.id, title: recipe.title, image: recipe.image))
                }
            }
            .listStyle(.plain)
            .navigationTitle("My Cookbook")
        }
    }
}

#Preview {
    NavigationStack {
        CookbookView()
    }
    .modelContainer(for: SavedRecipe.self, inMemory: true)
}
