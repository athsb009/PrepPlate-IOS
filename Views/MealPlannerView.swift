//
//  MealPlannerView.swift
//  PrepPlate
//
//  Created by Atharva Bibave on 10/27/25.
//

import SwiftUI
import SwiftData

struct MealPlannerView: View {
    @Environment(\.modelContext) private var modelContext
    
    @State private var selectedDate: Date = Date()
    @Query(sort: \MealPlanEntry.date)
    private var mealEntries: [MealPlanEntry]
    
    @State private var activeSheet: MealSheetConfig?
    
    var body: some View {
            VStack {
                DatePicker(
                    "Select a date",
                    selection: $selectedDate,
                    displayedComponents: .date
                )
                .datePickerStyle(.graphical)
                .padding(.horizontal)
                
                List {
                    ForEach(MealType.allCases, id: \.self) { mealType in
                        Section(header: Text(mealType.rawValue)) {
                            
                            let entriesForMeal = mealEntries.filter {
                                Calendar.current.isDate($0.date, inSameDayAs: selectedDate) &&
                                $0.mealType == mealType
                            }
                            
                            ForEach(entriesForMeal) { entry in
                                NavigationLink(destination: RecipeDetailView(recipeID: entry.recipeID)) {
                                    Text(entry.recipeTitle)
                                }
                            }
                            .onDelete { offsets in
                                deleteMeal(at: offsets, for: entriesForMeal)
                            }
                            
                            Button(action: {
                                self.activeSheet = MealSheetConfig(type: mealType)
                            }) {
                                Label("Add \(mealType.rawValue)", systemImage: "plus")
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Meal Planner")
            .sheet(item: $activeSheet) { config in
                SelectRecipeForPlanView(
                    selectedDate: selectedDate,
                    mealType: config.type
                )
            }
        }
        
        private func deleteMeal(at offsets: IndexSet, for entries: [MealPlanEntry]) {
            withAnimation {
                for index in offsets {
                    let entryToDelete = entries[index]
                    modelContext.delete(entryToDelete)
                }
            }
        }
    }

struct MealSheetConfig: Identifiable {
    let id = UUID()
    let type: MealType
}

struct SelectRecipeForPlanView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @Query(sort: \SavedRecipe.savedAt, order: .reverse)
    private var savedRecipes: [SavedRecipe]
    
    let selectedDate: Date
    let mealType: MealType
    
    var body: some View {
        NavigationStack {
            List(savedRecipes) { recipe in
                Button(action: {
                    let newEntry = MealPlanEntry(date: selectedDate, mealType: mealType, recipe: recipe)
                    modelContext.insert(newEntry)
                    dismiss()
                }) {
                    RecipeCard(recipe: Recipe(id: recipe.id, title: recipe.title, image: recipe.image))
                }
                .buttonStyle(.plain)
            }
            .navigationTitle("Select a Recipe")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}
