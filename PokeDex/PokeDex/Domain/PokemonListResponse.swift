//
//  PokemonListResponse.swift
//  PokeDex
//
//  Created by Salvatore Raso on 23/06/24.
//

import Foundation

struct PokemonListResponse: Decodable {
    let name: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case name, url
    }
}
