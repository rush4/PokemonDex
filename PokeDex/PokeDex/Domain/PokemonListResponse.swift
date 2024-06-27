//
//  PokemonListResponse.swift
//  PokeDex
//
//  Created by Salvatore Raso on 23/06/24.
//

import Foundation

struct PokemonListResponse: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PokemonType]
}

class Pokemon {
    let name: String
    let image: String
    let description: String
    let types: [PokemonTypeEntry]
    
    init(name: String, image: String, description: String, types: [PokemonTypeEntry]) {
        self.name = name
        self.image = image
        self.description = description
        self.types = types
    }
}
