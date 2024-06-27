//
//  PokeDexTests.swift
//  PokeDexTests
//
//  Created by Salvatore Raso on 21/06/24.
//

import XCTest
@testable import PokeDex

final class PokeDexTests: XCTestCase {
    
    let container: ComponentsContainer = ComponentsContainer()
    lazy var core = FakeCore(container: container, service: FakeService())

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoadList() throws {
        
        let waitingTime = 3.0
        let expectation = XCTestExpectation(description: "Run test asynchronously.")
        
        let viewModel = PokemonListVm()
        viewModel.service = core.serviceCore
        
        viewModel.viewIsReady()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + waitingTime) {
            
            XCTAssertFalse(viewModel.serviceInError)
            XCTAssertEqual(viewModel.pokemonListToShow.count, 4)
            XCTAssertEqual(viewModel.pokemonListToShow.first?.name, "bulbasaur")
            expectation.fulfill()
        }
        
        let result = XCTWaiter.wait(for: [expectation], timeout: waitingTime + 1.0)
        XCTAssertNotEqual(result, .timedOut)
    }
    
    func testSearchList() throws {
        
        let waitingTime = 3.0
        let expectation = XCTestExpectation(description: "Run test asynchronously.")
        
        let viewModel = PokemonListVm()
        viewModel.service = core.serviceCore
        
        viewModel.viewIsReady()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + waitingTime) {
            
            viewModel.searchData(query: "bulb")
            
            XCTAssertFalse(viewModel.serviceInError)
            XCTAssertEqual(viewModel.pokemonListFiltered.count, 1)
            XCTAssertEqual(viewModel.pokemonListFiltered.first?.name, "bulbasaur")
            expectation.fulfill()
        }
        
        let result = XCTWaiter.wait(for: [expectation], timeout: waitingTime + 1.0)
        XCTAssertNotEqual(result, .timedOut)
    }
    
    func testError() throws {
        
        let waitingTime = 3.0
        let expectation = XCTestExpectation(description: "Run test asynchronously.")
        
        let errorService = FakeService()
        errorService.isInError = true
        
        let errorCore = FakeCore(container: container, service: errorService)
        self.core = errorCore
        
        let viewModel = PokemonListVm()
        viewModel.service = core.serviceCore
        
        viewModel.viewIsReady()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + waitingTime) {
            
            XCTAssert(viewModel.serviceInError)
            XCTAssertEqual(viewModel.pokemonListToShow.count, 0)
            expectation.fulfill()
        }
        
        let result = XCTWaiter.wait(for: [expectation], timeout: waitingTime + 1.0)
        XCTAssertNotEqual(result, .timedOut)
    }


}
