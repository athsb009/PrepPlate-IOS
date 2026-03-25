//
//  ContentView.swift
//  PrepPlate
//
//  Created by Atharva Bibave on 10/27/25.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Tab = .home
    
    enum Tab {
        case home
        case planner
        case cookbook
        case list
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
      
            NavigationStack {
                HomeView()
            }
            .tabItem {
                Label("Discover", systemImage: "house")
            }
            .tag(Tab.home)
            
            NavigationStack {
                MealPlannerView()
            }
            .tabItem {
                Label("Planner", systemImage: "calendar")
            }
            .tag(Tab.planner)
            
            NavigationStack {
                CookbookView()
            }
            .tabItem {
                Label("Cookbook", systemImage: "book")
            }
            .tag(Tab.cookbook)
            
            NavigationStack {
                ShoppingListView()
            }
            .tabItem {
                Label("List", systemImage: "cart")
            }
            .tag(Tab.list)
        }
    }
}
