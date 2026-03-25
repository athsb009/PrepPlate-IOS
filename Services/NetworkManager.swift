//
//  NetworkManager.swift
//  PrepPlate
//
//  Created by Atharva Bibave on 10/27/25.
//

//
//  NetworkManager.swift
//  PrepPlate
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let apiKey = "259c9f960c50480398e10b6ac2763762"
    //6256653c465b4f8482f38500dbf50788 -> Spare Api Key
    
    private let baseURL = "https://api.spoonacular.com/recipes/"
    
    private init() {}
    
  
    func searchRecipes(query: String) async throws -> [Recipe] {
        let endpoint = "\(baseURL)complexSearch?query=\(query)&apiKey=\(apiKey)"
        
        guard let url = URL(string: endpoint) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decodedResponse = try JSONDecoder().decode(RecipeSearchResponse.self, from: data)
        
        return decodedResponse.results
    }
 
    func getRecipeDetails(id: Int) async throws -> RecipeDetail {
        let endpoint = "\(baseURL)\(id)/information?apiKey=\(apiKey)"
        
        guard let url = URL(string: endpoint) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decodedResponse = try JSONDecoder().decode(RecipeDetail.self, from: data)
        
        return decodedResponse
    }
}
