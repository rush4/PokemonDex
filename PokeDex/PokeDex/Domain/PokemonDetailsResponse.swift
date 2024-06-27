//
//  PokemonDetailsResponse.swift
//  PokeDex
//
//  Created by Salvatore Raso on 27/06/24.
//

import Foundation

struct PokemonDetailsResponse: Codable {
    let sprites: Sprites
    let types: [PokemonTypeEntry]
    let species: PokemonSpecies
}

struct Sprites: Codable {
    let front_default: String
}

struct PokemonTypeEntry: Codable {
    let slot: Int
    let type: PokemonType
}

struct PokemonType: Codable {
    let name: String
    let url: String
}

struct PokemonSpecies: Codable {
    let name: String
    let url: String
}

