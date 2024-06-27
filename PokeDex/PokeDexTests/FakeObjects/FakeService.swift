//
//  FakeService.swift
//  PokeDexTests
//
//  Created by Salvatore Raso on 27/06/24.
//

@testable import PokeDex

class FakeService: ServiceCoreProtocol {
    
    var isInError = false
    
    func fetchPokemonList(_ numberOfRow: Int) async -> Result<PokemonListResponse, Error> {
        
        if !isInError {
            .success(FakeResponses().buildPokemonListResponse())
        } else {
            .failure(NetworkError.serverError)
        }
        
    }
    
    func fetchPokemonDetails(url: String) async -> Result<PokemonDetailsResponse, Error> {
        if !isInError {
            .success(FakeResponses().buildPokemonDetailsResponse(url))
        } else {
            .failure(NetworkError.serverError)
        }
    }
    
    func fetchPokemonSpecies(url: String) async -> Result<PokemonSpeciesResponse, Error> {
        if !isInError {
            .success(FakeResponses().buildPokemonSpeciesResponse(url))
        } else {
            .failure(NetworkError.serverError)
        }
    }
}

enum NetworkError: Error {
    case serverError
}
