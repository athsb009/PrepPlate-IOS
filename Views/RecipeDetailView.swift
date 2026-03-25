//
//  RecipeDetailView.swift
//  PrepPlate
//
//  Created by Atharva Bibave on 10/27/25.
//

import SwiftUI
import SwiftData

struct RecipeDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var savedRecipes: [SavedRecipe]
    
    let recipeID: Int
    
    @State private var recipe: RecipeDetail?
    @State private var isLoading: Bool = true
    @State private var showConfirmation: Bool = false
    @State private var isSaved: Bool = false
    @State private var buttonScale: CGFloat = 1.0
    
    @State private var isIngredientsAdded: Bool = false
    
    var body: some View {
        ZStack {
            ScrollView {
                if isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, minHeight: 300)
                } else if let recipe = recipe {
                    VStack(alignment: .leading, spacing: 16) {
                        
                        AsyncImage(url: URL(string: recipe.image ?? "")) { image in
                            image.resizable().aspectRatio(contentMode: .fill)
                        } placeholder: {
                            Image(systemName: "photo.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .foregroundStyle(.gray)
                        }
                        .frame(height: 250)
                        .background(Color(.systemGray5))
                        .clipped()
                        
                        Text(recipe.title ?? "Unknown Recipe")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        
                        HStack(spacing: 16) {
                            Button(action: toggleSave) {
                                Label(isSaved ? "Saved" : "Save", systemImage: isSaved ? "bookmark.fill" : "bookmark")
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity)
                            }
                            .buttonStyle(.bordered)
                            .tint(isSaved ? .indigo : .orange)
                            .frame(height: 50)
                            
                            Button(action: addIngredients) {
                                Label(isIngredientsAdded ? "Added" : "Add Ingredients",
                                      systemImage: isIngredientsAdded ? "cart.fill" : "cart.badge.plus")
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity)
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(isIngredientsAdded ? .gray : .green)
                            .scaleEffect(buttonScale)
                            .frame(height: 50)
                            .disabled(isIngredientsAdded)
                        }
                        .padding(.horizontal)
                        .font(.headline)

                        VStack(alignment: .leading, spacing: 8) {
                            Text("Ingredients")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.green)
                            
                            ForEach(recipe.extendedIngredients ?? [], id: \.original) { ingredient in
                                Text("• \(ingredient.original)")
                            }
                        }
                        .padding(.horizontal)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Instructions")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.green)
                            
                            Text(recipe.instructions?.cleanHTML() ?? "No instructions provided.")
                        }
                        .padding([.top, .horizontal])
                        
                        Spacer()
                    }
                } else {
                    Text("Failed to load recipe.")
                        .padding()
                }
            }
            .navigationTitle(recipe?.title ?? "Loading...")
            .navigationBarTitleDisplayMode(.inline)
            .task {
                await fetchRecipeDetails()
                checkIfSaved()
            }
            .disabled(showConfirmation)
            
            if showConfirmation {
                VStack(spacing: 10) {
                    Image(systemName: "checkmark.circle")
                        .font(.largeTitle)
                        .foregroundColor(.green)
                    Text("Ingredients Added")
                        .font(.headline)
                        .fontWeight(.semibold)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(15)
                .shadow(radius: 5)
                .transition(.opacity.combined(with: .scale(scale: 0.8)))
            }
        }
    }
    
    
    func fetchRecipeDetails() async {
        isLoading = true
        do {
            let fetchedRecipe = try await NetworkManager.shared.getRecipeDetails(id: recipeID)
            self.recipe = fetchedRecipe
            self.isLoading = false
        } catch {
            print("Error fetching details: \(error.localizedDescription)")
            self.isLoading = false
        }
    }
    
    private func addIngredients() {
        guard !isIngredientsAdded else { return }
        guard !showConfirmation else { return }
        
        let ingredients = recipe?.extendedIngredients ?? []
        guard !ingredients.isEmpty else { return }

        isIngredientsAdded = true

        for ingredient in ingredients {
            let newItem = ShoppingItem(name: ingredient.name, originalString: ingredient.original)
            modelContext.insert(newItem)
        }
        
        withAnimation(.spring(response: 0.2, dampingFraction: 0.6)) { buttonScale = 1.1 }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            withAnimation(.spring(response: 0.2, dampingFraction: 0.6)) { buttonScale = 1.0 }
        }
        withAnimation(.spring()) { showConfirmation = true }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(.spring()) { showConfirmation = false }
        }
    }
    
    private func checkIfSaved() {
        isSaved = savedRecipes.contains { $0.id == recipeID }
    }
    
    private func toggleSave() {
        guard let recipe = recipe else { return }
        
        withAnimation {
            if isSaved {
                if let savedItem = savedRecipes.first(where: { $0.id == recipe.id }) {
                    modelContext.delete(savedItem)
                    isSaved = false
                }
            } else {
                let newSavedRecipe = SavedRecipe(
                    id: recipe.id,
                    title: recipe.title ?? "Unknown",
                    image: recipe.image ?? ""
                )
                modelContext.insert(newSavedRecipe)
                isSaved = true
            }
        }
    }
}
