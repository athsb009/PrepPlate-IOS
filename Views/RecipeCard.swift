//
//  RecipeCard.swift
//  PrepPlate
//
//  Created by Atharva Bibave on 10/29/25.
//

import SwiftUI

struct RecipeCard: View {
    let recipe: Recipe
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: recipe.image)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60, height: 60)
                    .background(Color(.systemGray4))
            }
            .frame(width: 60, height: 60)
            .cornerRadius(10)
            
            VStack(alignment: .leading) {
                Text(recipe.title)
                    .fontWeight(.semibold)
                    .lineLimit(2)
            }
            Spacer()
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}
