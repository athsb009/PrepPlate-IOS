# PrepPlate 🥗
### A native iOS app for recipe discovery, meal planning, and smart shopping lists

---

## Overview

PrepPlate streamlines the cooking experience for students and home cooks. Discover trending recipes, build a personal cookbook, plan your meals for the week, and generate shopping lists automatically — all in one polished native iOS app.

---

## Features

**Recipe Discovery**
- Live search powered by the Spoonacular API
- Browse trending recipes updated in real time
- Recently Viewed history for quick access

**Smart Cookbook**
- Save and organize favorite recipes locally
- Persistent offline storage — your cookbook is always available
- Clean, browsable collection view

**Meal Planner**
- Schedule Breakfast, Lunch, and Dinner for any date
- Calendar-based interface for weekly planning
- Visual overview of your upcoming meals

**Shopping List**
- Add ingredients directly from any recipe detail view
- Interactive checklist — check off items as you shop
- Delete items individually or clear the full list

---

## Technical Implementation

| Layer | Technology |
|-------|-----------|
| UI Framework | SwiftUI (VStack, ZStack, LazyVGrid, Sheets) |
| Persistence | SwiftData (@Model, @Query, @Environment) |
| Networking | async/await + URLSession + Codable |
| API | Spoonacular REST API |
| Platform | iOS 17+, Xcode 15+ |

**Notable engineering decisions:**
- `async/await` for clean, readable async networking without callback hell
- SwiftData for lightweight local persistence with zero boilerplate
- Custom `String` extensions to sanitize HTML from API recipe instructions
- Duplicate API ID handling and optional field safety to prevent crashes under real-world API conditions

---

## Setup

### Prerequisites
- Xcode 15 or later
- iOS 17+ Simulator or physical device
- Spoonacular API key (free tier available at [spoonacular.com](https://spoonacular.com/food-api))

### Run Locally

```bash
# Clone the repo
git clone https://github.com/athsb009/PrepPlateIOS
cd PrepPlateIOS
```

1. Open `PrepPlate.xcodeproj` in Xcode
2. Navigate to `Services/NetworkManager.swift`
3. Add your Spoonacular API key to the `apiKey` variable
4. Select a simulator (iPhone 16 Pro Max recommended)
5. Press `Cmd + R` to build and run

---

## API Note

PrepPlate uses the Spoonacular free tier (50 points/day). Two backup API keys are provided in `NetworkManager.swift` — if one limit is reached, switch to the next. The app includes full error handling to prevent crashes when the quota resets.

---

## Screenshots

> Add screenshots here

---

## Author

**Atharva Bibave**
- [LinkedIn](https://linkedin.com/in/atharvabibave)
- [GitHub](https://github.com/athsb009)
