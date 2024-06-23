//
//  ServiceCore.swift
//  PokeDex
//
//  Created by Salvatore Raso on 23/06/24.
//

import Foundation

protocol ServiceCoreProtocol{
    func fetchPokemon(offset: Int, limit: Int) async -> Result<[PokemonListResponse], Error>
}

struct ServiceCore:  ServiceCoreProtocol {
    private let baseURL = "https://pokeapi.co/api/v2/pokemon"
    
    func fetchPokemon(offset: Int, limit: Int) async -> Result<[PokemonListResponse], Error> {
        let url = URL(string: "\(baseURL)?offset=\(offset)&limit=\(limit)")!
        
        var request = URLRequest(url: url)
        
        return await withCheckedContinuation { continuation in
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    return continuation.resume(returning: .failure(error ?? NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unknown error"])))
                }
                
                do {
                    let response = try JSONDecoder().decode([PokemonListResponse].self, from: data)
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


struct Pokemon: Codable {
    let name: String
    let url: String
}


