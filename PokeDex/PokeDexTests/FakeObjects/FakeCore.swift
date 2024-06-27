//
//  FakeCore.swift
//  PokeDexTests
//
//  Created by Salvatore Raso on 27/06/24.
//

@testable import PokeDex

class FakeCore: BaseCore {
    
    /// Dependencies container
    let container: Container
    
    lazy var serviceCore: ServiceCoreProtocol = ServiceCore()
    
    init(container: Container) {
        self.container = container
    }
}
