//
//  PokemonListResponse.swift
//  PokeDex
//
//  Created by Salvatore Raso on 23/06/24.
//

import Foundation

struct PokemonListResponse: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Pokemon]
    
    enum CodingKeys: String, CodingKey {
        case count, next, previous, results
    }
}
