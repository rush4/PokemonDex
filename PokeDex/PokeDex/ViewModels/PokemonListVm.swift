//
//  PokemonListVm.swift
//  PokeDex
//
//  Created by Salvatore Raso on 23/06/24.
//

import Foundation
import UIKit
import Combine

class PokemonListVm {
    
    // MARK: - Properties
    
    // Service object to fetch pokemon data
    var service: ServiceCoreProtocol? = nil
    
    // Published properties to observe changes
    @Published var pokemonListToShow: [Pokemon] = []
    @Published var pokemonListFiltered: [Pokemon] = []
    @Published var serviceInError: Bool = false
    @Published var isLoading: Bool = false
    
    // Internal properties
    var pokemonList: [Pokemon] = [] // Stores all fetched Pokemon
    var queryToSearch: String? // Stores the current search query
    
    // MARK: - Initialization
    
    // Initialization sets up the service dependency
    init() {
        // Resolve the service dependency using the app delegate's container
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
              let serviceCore = appDelegate.container.resolve(type: ServiceCoreProtocol.self)  else {
            // If service cannot be resolved, assert and terminate initialization
            assert(false, "impossibile risolvere ServiceCoreProtocol")
            return
        }
        service = serviceCore
    }
    
    // MARK: - View Logic
    
    // Called when the view is ready to fetch data
    func viewIsReady() {
        retrieveData()
    }
    
    // Performs search based on given query
    func searchData(query: String) {
        self.queryToSearch = query
        // Filters pokemonList based on uppercase name containing the uppercase query
        pokemonListFiltered = pokemonList.filter({ pokemon in
            let name = pokemon.name.uppercased()
            return name.contains(query.uppercased())
        })
    }
    
    // MARK: - Data Fetching
    
    // Fetches initial Pokemon data
    func retrieveData() {
        isLoading = true // Set loading indicator
        Task {
            let result = await service?.fetchPokemonList(self.pokemonList.count)
            
            switch result {
            case .success(let response):
                // On successful data fetch
                self.serviceInError = false
                await self.fetchPokemonDetails(for: response.results)
                
            case .failure(_):
                // On fetch failure
                isLoading = false // Stop loading indicator
                self.serviceInError = true
                
            case .none:
                break
            }
        }
    }
    
    // Fetches details for each Pokemon in the list
    func fetchPokemonDetails(for list: [PokemonType]) async {
        var arrayOfPokemon: [Pokemon] = []
        
        for item in list {
            let details = await self.service?.fetchPokemonDetails(url: item.url)
            
            switch details {
            case .success(let response):
                // On successful detail fetch
                let description = await self.retrieveSpecies(response.species.url)
                
                let pokemon : Pokemon = Pokemon(name: item.name,
                                                image: response.sprites.front_default,
                                                description: description ?? "",
                                                types: response.types)
                
                self.pokemonList.append(pokemon)
                arrayOfPokemon.append(pokemon)
                
            default:
                break
            }
        }
        self.pokemonListToShow = arrayOfPokemon // Update shown Pokemon list
        isLoading = false // Stop loading indicator
    }
    
    // Fetches species details for a Pokemon
    func retrieveSpecies(_ url: String) async -> String? {
        let species = await service?.fetchPokemonSpecies(url: url)
        
        switch species {
        case .success(let response):
            // On successful species fetch, filter and return description
            let description = response.flavor_text_entries.filter { item in
                item.version.name == "shield" && item.language.name == "en"
            }
            return description.first?.flavor_text
            
        case .failure(_):
            // On failure to fetch species
            print("Error fetching description")
            return nil
            
        case .none:
            return nil
        }
    }
}
