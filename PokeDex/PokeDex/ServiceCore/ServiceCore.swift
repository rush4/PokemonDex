//
//  ServiceCore.swift
//  PokeDex
//
//  Created by Salvatore Raso on 23/06/24.
//

import Foundation

protocol ServiceCoreProtocol{
    func fetchPokemonList() async -> Result<PokemonListResponse, Error>
    func fetchPokemonDetails(url: String) async -> Result<PokemonDetailsResponse, Error>
    func fetchPokemonSpecies(url: String) async -> Result<PokemonSpeciesResponse, Error>
}

struct ServiceCore:  ServiceCoreProtocol {
    private let baseURL = "https://pokeapi.co/api/v2/"
    
    func fetchPokemonList() async -> Result<PokemonListResponse, Error> {
        
        guard let url = URL(string: "\(baseURL)pokemon?offset=20&limit=20") else {
            return (.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
        }
        
        let request = URLRequest(url: url)
        
        return await withCheckedContinuation { continuation in
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                
                guard let data = data, error == nil else {
                    return continuation.resume(returning: .failure(error ?? NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unknown error"])))
                }
                
                do {
                    let response = try JSONDecoder().decode(PokemonListResponse.self, from: data)
                    print(response)
                    return continuation.resume(returning: .success(response))
                } catch {
                    print("Error decoding JSON:", error)
                    
                    return continuation.resume(returning: .failure(error))
                }
            }.resume()
        }
    }
    
    func fetchPokemonDetails(url: String) async -> Result<PokemonDetailsResponse, Error> {
        
        guard let url = URL(string: url) else {
            return (.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
        }
        
        let request = URLRequest(url: url)
        
        return await withCheckedContinuation { continuation in
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                
                guard let data = data, error == nil else {
                    return continuation.resume(returning: .failure(error ?? NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unknown error"])))
                }
                
                do {
                    let response = try JSONDecoder().decode(PokemonDetailsResponse.self, from: data)
                    print(response)
                    return continuation.resume(returning: .success(response))
                } catch {
                    print("Error decoding JSON:", error)
                    
                    return continuation.resume(returning: .failure(error))
                }
            }.resume()
        }
    }
    
    func fetchPokemonSpecies(url: String) async -> Result<PokemonSpeciesResponse, Error> {
        
        guard let url = URL(string: url) else {
            return (.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
        }
        
        let request = URLRequest(url: url)
        
        return await withCheckedContinuation { continuation in
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                
                guard let data = data, error == nil else {
                    return continuation.resume(returning: .failure(error ?? NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unknown error"])))
                }
                
                do {
                    let response = try JSONDecoder().decode(PokemonSpeciesResponse.self, from: data)
                    print(response)
                    return continuation.resume(returning: .success(response))
                } catch {
                    print("Error decoding JSON:", error)
                    
                    return continuation.resume(returning: .failure(error))
                }
            }.resume()
        }
    }
}


