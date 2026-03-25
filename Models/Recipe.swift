//
//  Recipe.swift
//  PrepPlate
//
//  Created by Atharva Bibave on 10/27/25.
//

//
//  Recipe.swift
//  PrepPlate
//

import Foundation

struct RecipeSearchResponse: Codable {
    let results: [Recipe]
}

struct Recipe: Codable, Identifiable {
    let id: Int
    let title: String
    let image: String
}

struct RecipeDetail: Codable, Identifiable {
    let id: Int
    let title: String?
    let image: String?
    let readyInMinutes: Int?
    let servings: Int?
    let extendedIngredients: [Ingredient]?
    let instructions: String?
}

struct Ingredient: Codable, Identifiable {
    let id: Int?
    let name: String
    let original: String
}
