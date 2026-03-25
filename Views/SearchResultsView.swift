//
//  SearchResultsView.swift
//  PrepPlate
//
//  Created by Atharva Bibave on 10/27/25.
//

import SwiftUI

struct SearchView: View {
    @Environment(\.dismiss) private var dismiss
    var initialQuery: String?
    
    @State private var searchText: String = ""
    @State private var searchResults: [Recipe] = []
    @State private var isLoading: Bool = false
    
    init(initialQuery: String? = nil) {
        self.initialQuery = initialQuery
        _searchText = State(initialValue: initialQuery ?? "")
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    TextField("Search for recipes...", text: $searchText)
                        .padding(10)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .onSubmit { search() }
                    
                    Button("Search") {
                        search()
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding(.horizontal)
                
                // --- RESULTS SECTION ---
                if isLoading {
                    ProgressView()
                        .padding()
                }
                
                ScrollView {
                    ForEach(searchResults) { recipe in
                        NavigationLink(destination: RecipeDetailView(recipeID: recipe.id)) {
                            RecipeCard(recipe: recipe)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                
                Spacer()
            }
            .padding(.top)
            .navigationTitle("Search Recipes")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .task {
               
                if let query = initialQuery, !query.isEmpty {
                    search()
                }
            }
        }
    }
    
    func search() {
        guard !searchText.isEmpty else { return }
        
        isLoading = true
        searchResults = []
        
        Task {
            do {
                let recipes = try await NetworkManager.shared.searchRecipes(query: searchText)
                DispatchQueue.main.async {
                    self.searchResults = recipes
                    self.isLoading = false
                }
            } catch {
                print("Error searching recipes: \(error.localizedDescription)")
                self.isLoading = false
            }
        }
    }
}
