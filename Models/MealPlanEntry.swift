//
//  MealPlanEntry.swift
//  PrepPlate
//
//  Created by Atharva Bibave on 10/27/25.
//

import Foundation
import SwiftData

@Model
final class MealPlanEntry {
    @Attribute(.unique) var id: UUID
    var date: Date
    var mealType: MealType
    
    var recipeID: Int
    var recipeTitle: String
    var recipeImage: String
    
    init(date: Date, mealType: MealType, recipe: SavedRecipe) {
        self.id = UUID()
        self.date = date
        self.mealType = mealType
        self.recipeID = recipe.id
        self.recipeTitle = recipe.title
        self.recipeImage = recipe.image
    }
}

enum MealType: String, Codable, CaseIterable {
    case breakfast = "Breakfast"
    case lunch = "Lunch"
    case dinner = "Dinner"
}
