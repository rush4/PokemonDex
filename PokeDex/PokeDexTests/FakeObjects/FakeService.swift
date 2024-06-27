//
//  FakeService.swift
//  PokeDexTests
//
//  Created by Salvatore Raso on 27/06/24.
//

@testable import PokeDex


class FakeService: ServiceCoreProtocol {
    func fetchPokemonList(_ numberOfRow: Int) async -> Result<PokemonListResponse, Error> {
        .success(FakeResponses().buildPokemonListResponse())
    }
    
    func fetchPokemonDetails(url: String) async -> Result<PokemonDetailsResponse, Error> {
        .success(FakeResponses().buildPokemonDetailsResponse())
    }
    
    func fetchPokemonSpecies(url: String) async -> Result<PokemonSpeciesResponse, Error> {
        .success(FakeResponses().buildPokemonSpeciesResponse())
    }
}
