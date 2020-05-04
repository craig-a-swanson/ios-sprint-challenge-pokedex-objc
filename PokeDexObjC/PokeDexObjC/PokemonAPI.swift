//
//  PokemonAPI.swift
//  PokeDexObjC
//
//  Created by Craig Swanson on 5/3/20.
//  Copyright © 2020 craigswanson. All rights reserved.
//

import Foundation
import UIKit

@objc class PokemonAPI: NSObject {
    
    @objc var pokemons: [Pokemon] = []
    @objc dynamic var selectedPokemon: Pokemon?
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    private let pokemonInDatabase: String = "964"
    
    @objc(sharedController) static let shared: PokemonAPI = PokemonAPI()
    
    @objc func fetchAllPokemon(completion: @escaping (Pokemon?, Error?) -> Void) {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let queryItem = URLQueryItem(name: "limit", value: pokemonInDatabase)
        urlComponents?.queryItems = [queryItem]
        guard let request = urlComponents?.url else { return }
        var requestURL = URLRequest(url: request)
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
    
    // fetch individual pokemon data
    
    
    // fetch sprite image
    func fetchSprite(at spriteURL: URL, completion: @escaping (UIImage?, Error?) -> Void) {
        let request = URLRequest(url: spriteURL)
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("Error getting sprite image: \(error)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, error)
                return
            }
            
            let image = UIImage(data: data)
            completion(image, nil)
        }.resume()
    }
    
    @objc func fillInDetails(for pokemon: Pokemon) {
        self.selectedPokemon = pokemon
    }
}
