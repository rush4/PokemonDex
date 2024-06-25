//
//  PokemonSpeciesResponse.swift
//  PokeDex
//
//  Created by Salvatore Raso on 25/06/24.
//

import Foundation

// Model for Language
struct Language: Decodable {
    let name: String
    let url: String
}

// Model for Version
struct Version: Decodable {
    let name: String
    let url: String
}

// Model for FlavorTextEntry
struct FlavorTextEntry: Decodable {
    let flavor_text: String
    let language: Language
    let version: Version
}

// Model for the top-level structure that contains flavor text entries
struct PokemonSpeciesResponse: Decodable {
    let flavor_text_entries: [FlavorTextEntry]
}

