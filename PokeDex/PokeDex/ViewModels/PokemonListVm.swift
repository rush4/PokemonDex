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
    
    // Service object to fetch pokemon data
    var service: ServiceCoreProtocol? = nil
    
    @Published var pokemonList: [Pokemon] = []
    @Published var pokemonListFiltered: [Pokemon] = []
    
    // Initialization
    init() {
        // Resolve the CoinGecko service dependency
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
              let serviceCore = appDelegate.container.resolve(type: ServiceCoreProtocol.self)  else {
            // Assert if unable to resolve the service
            assert(false, "impossibile risolvere ServiceCoreProtocol")
            return
        }
        service = serviceCore
    }
    
    func viewIsReady() {
        //        guard !isMock else {
        //            self.view?.viewState = listViewState
        //            return
        //        }
        retrieveData()
    }
    
    func searchData(query: String) {
        
        pokemonListFiltered = pokemonList.filter({ pokemon in
            let name = pokemon.name.uppercased()
            return name.contains(query.uppercased())
        })
        
        
        
    }
    
    func retrieveData(){
        Task {
            let result = await service?.fetchPokemonList(self.pokemonList.count)
            
            switch result {
            case .success(let response):
                                
                await self.fetchPokemonDetails(for: response.results)
                
            case .failure(_):
                print("Error fetching pokemon")
                break
            case .none:
                break
            }
        }
    }
    
    func fetchPokemonDetails(for list: [PokemonType]) async {
        
        var arrayOfPokemon: [Pokemon] = []
        
        for item in list {
            
            let details = await self.service?.fetchPokemonDetails(url: item.url)
            
            switch details {
            case .success(let response):
                
                let description = await self.retrieveSpecies(response.species.url)
                
                let pokemon : Pokemon = Pokemon(name: item.name,
                                                image: response.sprites.front_default,
                                                description: description ?? "",
                                                types: response.types)
                
                arrayOfPokemon.append(pokemon)
                
            default:
                break
            }
            
        }
        self.pokemonList = arrayOfPokemon
    }
    
    func retrieveSpecies(_ url: String) async -> String? {
        
        let species = await service?.fetchPokemonSpecies(url: url)
        
        switch species {
        case .success(let response):
            
            let description = response.flavor_text_entries.filter { item in
                item.version.name == "shield" && item.language.name == "en"
            }
            
            return description.first?.flavor_text
            
        case .failure(_):
            print("Error fetching pokemon")
            return nil
        case .none:
            return nil
        }
    }
}
