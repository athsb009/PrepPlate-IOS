//
//  ShoppingItem.swift
//  PrepPlate
//
//  Created by Atharva Bibave on 10/27/25.
//

import Foundation
import SwiftData

@Model
final class ShoppingItem {
    @Attribute(.unique) var id: UUID
    
    var name: String
    var originalString: String
    var isCompleted: Bool
    var createdAt: Date
    
    init(name: String, originalString: String) {
        self.id = UUID()
        self.name = name
        self.originalString = originalString
        self.isCompleted = false
        self.createdAt = Date()
    }
}
