//
//  HomeView.swift
//  PrepPlate
//
//  Created by Atharva Bibave on 10/27/25.
//

import SwiftUI
import SwiftData
struct HomeView: View {
    @Query(sort: \SavedRecipe.savedAt, order: .reverse)
        private var savedRecipes: [SavedRecipe]
    
    @State private var activeSearch: SearchConfig?
    
    let trendingRecipes: [Recipe] = [
            Recipe(id: 716628, title: "Slow Cooker Beef Curry", image: "https://spoonacular.com/recipeImages/716628-312x231.jpg"),
            
            Recipe(id: 660405, title: "Smoky Black Beans Soup", image: "https://spoonacular.com/recipeImages/660405-312x231.jpg"),
            
            Recipe(id: 637593, title: "Cheese Tortellini with Shrimp", image: "https://spoonacular.com/recipeImages/637593-312x231.jpg")
        ]
    
    let cuisines = ["Italian", "Mexican", "Indian", "Chinese", "Japanese", "Thai"]
    let gridColumns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    var body: some View {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    
                    Text("Discover Recipes")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                    
                    Button(action: {
                        self.activeSearch = SearchConfig(query: "")
                    }) {
                        HStack {
                            Image(systemName: "magnifyingglass")
                            Text("Search for recipes...")
                            Spacer()
                        }
                        .padding(10)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .foregroundColor(.gray)
                    }
                    .padding(.horizontal)
                    

                    VStack(alignment: .leading) {
                        Text("Browse Cuisines")
                            .font(.headline)
                            .fontWeight(.bold)
                    }
                    .padding(.horizontal)

                    LazyVGrid(columns: gridColumns, spacing: 15) {
                        ForEach(cuisines, id: \.self) { cuisine in
                            Button(action: {
                            
                                self.activeSearch = SearchConfig(query: cuisine)
                            }) {
                                Text(cuisine)
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.green)
                                    .cornerRadius(10)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .padding(.horizontal)
                    
     
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Trending Recipes")
                            .font(.headline)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                ForEach(trendingRecipes) { recipe in
                                    NavigationLink(destination: RecipeDetailView(recipeID: recipe.id)) {
                                        TrendingRecipeCard(title: recipe.title, image: recipe.image)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
   
                    if !savedRecipes.isEmpty {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Your Recently Saved")
                                .font(.headline)
                                .fontWeight(.bold)
                                .padding(.horizontal)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 15) {
                                    ForEach(savedRecipes.prefix(4)) { recipe in
                                        NavigationLink(destination: RecipeDetailView(recipeID: recipe.id)) {
                                            TrendingRecipeCard(title: recipe.title, image: recipe.image)
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                        .id(recipe.persistentModelID)
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                    
                    Spacer()
                }
                .padding(.top)
            }
            .navigationBarHidden(true)
            .sheet(item: $activeSearch) { config in
                SearchView(initialQuery: config.query)
            }
        }
    }

    struct SearchConfig: Identifiable {
        let id = UUID()
        let query: String
    }


    struct TrendingRecipeCard: View {
        let title: String
        let image: String
        
        var body: some View {
            VStack(alignment: .leading) {
                AsyncImage(url: URL(string: image)) { phase in
                    switch phase {
                    case .empty:
                        Image(systemName: "photo")
                            .resizable().aspectRatio(contentMode: .fit)
                            .frame(width: 140, height: 100)
                            .background(Color(.systemGray4))
                    case .success(let image):
                        image.resizable().aspectRatio(contentMode: .fill)
                            .frame(width: 140, height: 100)
                            .clipped()
                    case .failure:
                        Image(systemName: "photo")
                            .resizable().aspectRatio(contentMode: .fit)
                            .frame(width: 140, height: 100)
                            .background(Color(.systemGray4))
                    @unknown default:
                        EmptyView()
                    }
                }
                .id(image)
                .frame(width: 140, height: 100)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.systemGray5), lineWidth: 1)
                )
                
                Text(title)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                    .frame(width: 140, alignment: .leading)
            }
        }
    }
