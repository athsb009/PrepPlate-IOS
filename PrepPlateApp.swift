//
//  PrepPlateApp.swift
//  PrepPlate
//
//  Created by Atharva Bibave on 10/27/25.
//

import SwiftUI
import SwiftData

@main
struct PrepPlateApp: App {
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            ShoppingItem.self,
            SavedRecipe.self,
            MealPlanEntry.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .tint(Color.green)
        }
        .modelContainer(sharedModelContainer)        
    }
}
