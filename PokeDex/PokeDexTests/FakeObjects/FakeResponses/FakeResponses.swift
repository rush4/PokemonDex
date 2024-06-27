//
//  FakeResponses.swift
//  PokeDexTests
//
//  Created by Salvatore Raso on 27/06/24.
//

@testable import PokeDex

struct FakeResponses {
    
    func buildPokemonListResponse() -> PokemonListResponse {
        
        let pokemonListResponse = PokemonListResponse(count: 1302, next: "https://pokeapi.co/api/v2/pokemon?offset=20&limit=20", previous: nil, results: [PokemonType(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/"),PokemonType(name: "ivysaur", url: "https://pokeapi.co/api/v2/pokemon/2/"),PokemonType(name: "venusaur", url: "https://pokeapi.co/api/v2/pokemon/3/"),PokemonType(name: "charmander", url: "https://pokeapi.co/api/v2/pokemon/4/")])
        
        return pokemonListResponse
    }
    
    func buildPokemonDetailsResponse(_ url: String) -> PokemonDetailsResponse {
        
        let pokemon1 = PokemonDetailsResponse(sprites: Sprites(front_default: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"), types: [PokemonTypeEntry(slot: 1, type: PokemonType(name: "grass", url: "https://pokeapi.co/api/v2/pokemon/1/"))], species: PokemonSpecies(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/"))
        
        let pokemon2 = PokemonDetailsResponse(sprites: Sprites(front_default: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/2.png"), types: [PokemonTypeEntry(slot: 1, type: PokemonType(name: "grass", url: "https://pokeapi.co/api/v2/pokemon/2/"))], species: PokemonSpecies(name: "ivysaur", url: "https://pokeapi.co/api/v2/pokemon/2/"))
        
        let pokemon3 = PokemonDetailsResponse(sprites: Sprites(front_default: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/3.png"), types: [PokemonTypeEntry(slot: 1, type: PokemonType(name: "grass", url: "https://pokeapi.co/api/v2/pokemon/3/"))], species: PokemonSpecies(name: "venusaur", url: "https://pokeapi.co/api/v2/pokemon/3/"))
        
        let pokemon4 = PokemonDetailsResponse(sprites: Sprites(front_default: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png"), types: [PokemonTypeEntry(slot: 1, type: PokemonType(name: "fire", url: "https://pokeapi.co/api/v2/pokemon/4/"))], species: PokemonSpecies(name: "charmender", url: "https://pokeapi.co/api/v2/pokemon/4/"))
        
        let arrayOfPokemon = [pokemon1, pokemon2, pokemon3, pokemon4]
        
        let item = arrayOfPokemon.first { item in
            item.types.contains { pokemon in
                pokemon.type.url == url
            }
        }
        
        return item ?? pokemon1
    }
    
    func buildPokemonSpeciesResponse(_ url: String) -> PokemonSpeciesResponse {
        
        let pokemon1 = PokemonSpeciesResponse(flavor_text_entries: [FlavorTextEntry(flavor_text: "While it is young, it uses the nutrients that are\nstored in the seed on its back in order to grow.", language: Language(name: "en", url: ""), version: Version(name: "shield", url: "https://pokeapi.co/api/v2/pokemon/1/"))])
        
        let pokemon2 = PokemonSpeciesResponse(flavor_text_entries: [FlavorTextEntry(flavor_text: "Exposure to sunlight adds to its strength.\nSunlight also makes the bud on its back\ngrow larger.", language: Language(name: "en", url: ""), version: Version(name: "shield", url: "https://pokeapi.co/api/v2/pokemon/2/"))])
        
        let pokemon3 = PokemonSpeciesResponse(flavor_text_entries: [FlavorTextEntry(flavor_text: "A bewitching aroma wafts from its flower.\nThe fragrance becalms those engaged\nin a battle.", language: Language(name: "en", url: ""), version: Version(name: "shield", url: "https://pokeapi.co/api/v2/pokemon/3/"))])
        
        let pokemon4 = PokemonSpeciesResponse(flavor_text_entries: [FlavorTextEntry(flavor_text: "From the time it is born, a flame burns at the tip\nof its tail. Its life would end if the flame were to\ngo out.", language: Language(name: "en", url: ""), version: Version(name: "shield", url: "https://pokeapi.co/api/v2/pokemon/4/"))])
        
        let arrayOfPokemon = [pokemon1, pokemon2, pokemon3, pokemon4]
        
        let item = arrayOfPokemon.first { item in
            item.flavor_text_entries.contains { pokemon in
                    pokemon.version.url == url
            }
        }
        
        return item ?? pokemon1
    }
}
