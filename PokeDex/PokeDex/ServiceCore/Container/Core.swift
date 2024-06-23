//
//  Core.swift
//  PokeDex
//
//  Created by Salvatore Raso on 23/06/24.
//

import Foundation

protocol BaseCore: AnyObject {
    var container: Container { get }
    var serviceCore: ServiceCoreProtocol { get }
}

class Core: BaseCore {
    
    /// Dependencies container
    let container: Container
    
    lazy var serviceCore: ServiceCoreProtocol = ServiceCore()
    
    init(container: Container) {
        self.container = container
    }
}

