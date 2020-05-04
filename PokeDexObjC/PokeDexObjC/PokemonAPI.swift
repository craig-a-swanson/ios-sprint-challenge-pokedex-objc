//
//  PokemonAPI.swift
//  PokeDexObjC
//
//  Created by Craig Swanson on 5/3/20.
//  Copyright © 2020 craigswanson. All rights reserved.
//

import Foundation

@ objc class PokemonAPI: NSObject {
    
    @objc(sharedController) static let shared: PokemonAPI = PokemonAPI()
    
    @objc func fetchAllPokemon(completion: @escaping ([Pokemon]?, Error?) -> Void) {
        
    }
    
    @objc func fillInDetails(for pokemon: Pokemon) {
        
    }
}
