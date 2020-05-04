//
//  PokemonAPI.swift
//  PokeDexObjC
//
//  Created by Craig Swanson on 5/3/20.
//  Copyright © 2020 craigswanson. All rights reserved.
//

import Foundation

@objc class PokemonAPI: NSObject {
    
    @objc var pokemons: [Pokemon] = []
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    @objc(sharedController) static let shared: PokemonAPI = PokemonAPI()
    
    @objc func fetchAllPokemon(completion: @escaping (Pokemon?, Error?) -> Void) {
        var requestURL = URLRequest(url: baseURL)
        requestURL.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: requestURL) { (possibleData, _, possibleError) in
            if let error = possibleError {
                print("Error getting pokemons with data task: \(error)")
                completion(nil, error)
                return
            }
            
            guard let data = possibleData else {
                NSLog("Returned bad data with data task")
                return
            }
            
            do {
                let jsonPokemonDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                let allPokes = Pokemon.init(tableViewWith: jsonPokemonDictionary!)
                self.pokemons = allPokes.allPokemon
                completion(allPokes, nil)
                
            } catch {
                print("Error decoding results of fetching all Pokemon: \(error)")
                completion(nil, error)
                return
            }
        }.resume()
    }
    
    @objc func fillInDetails(for pokemon: Pokemon) {
        
    }
}
