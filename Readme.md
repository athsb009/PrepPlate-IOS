//
//  Readme.md
//  PrepPlateIOS
//
//  Created by Atharva Bibave on 11/30/25.
//

PrepPlate 🥗
Student Name: Atharva Bibave

📱 App Overview
PrepPlate is a native iOS application designed to streamline the cooking experience. It allows users to discover new recipes via a live API, manage a personal cookbook, plan daily meals, and automatically generate shopping lists.

✨ Key Features
Recipe Discovery: Live search and "Trending" recipes powered by the Spoonacular API.

Smart Cookbook: Save and organize favorite recipes locally using SwiftData.

Meal Planner: Schedule multiple meals (Breakfast, Lunch, Dinner) for any specific date on a calendar.

Shopping List: Add ingredients directly from a recipe detail view; fully interactive (check off/delete items).

Polished UI: Includes custom animations, modal search sheets, and "Recently Viewed" history.

🛠 Technical Implementation
Framework: SwiftUI (VStack, ZStack, LazyVGrid, Sheets).

Persistence: SwiftData (@Model, @Query, @Environment(\.modelContext)) for offline storage.

Networking: async/await and URLSession with Codable for JSON parsing.

Data Handling: Custom String extensions to clean HTML tags from API instructions.

Robustness: Handling duplicate API IDs and optional data fields to prevent crashes.

🚀 How to Run
Open PrepPlate.xcodeproj in Xcode 15 or later.

Navigate to Services/NetworkManager.swift.

Ensure the apiKey variable contains a valid Spoonacular API key.

Select a Simulator (e.g., iPhone 16 Pro Max) and press Run (Cmd + R).

📝 Note on API Limits

The app uses the free tier of the Spoonacular API (50 points/day). If the limit is reached, the app includes error handling to prevent crashes, though search results may not appear until the quota resets. Please use another key in that case I have Provided 2 of them in NetworkManager.
