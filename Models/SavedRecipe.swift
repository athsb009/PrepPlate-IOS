//
//  SavedRecipe.swift
//  PrepPlate
//
//  Created by Atharva Bibave on 10/27/25.
//


import Foundation
import SwiftData

@Model
final class SavedRecipe {
    @Attribute(.unique) var id: Int
    
    var title: String
    var image: String 
    var savedAt: Date
    
    init(id: Int, title: String, image: String) {
        self.id = id
        self.title = title
        self.image = image
        self.savedAt = Date()
    }
}
