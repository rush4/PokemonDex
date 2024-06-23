//
//  PokemonListVm.swift
//  PokeDex
//
//  Created by Salvatore Raso on 23/06/24.
//

import Foundation
import UIKit

class PokemonListVm {
    
    // Closure to handle navigation to pokemon details
    var goToPokemonDetailsClosure: ((_ cryptoId: String) -> Void)?
    
    // Service object to fetch pokemon data
    var service: ServiceCoreProtocol? = nil
    
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
}
