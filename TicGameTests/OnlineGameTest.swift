//
//  OnlineGameTest.swift
//  TicGameTests
//
//  Created by Jordan Isac on 20/12/2023.
//

import XCTest
import Factory
import Combine

@testable import TicGame

final class OnlineGameTest: XCTestCase {

    private var cancellables: Set<AnyCancellable> = []
    
    func test_joinGameReturnReadyGame() async throws {
        Container.setupMocs()
        
        let sut = OnlineGameRepository()
        
        sut.$game
            .dropFirst()
            .sink { newValue in
                XCTAssertEqual(newValue?.id, "MocID")
                XCTAssertEqual(newValue?.player1Id, "P1ID")
            }
        
        await sut.joinGame()
    }
    
    func test_joinGameCreatesNewGame() async throws {
        Container.setupMocs(ShouldReturnNil: true)
        
        let sut = OnlineGameRepository()
        
        sut.$game
            .dropFirst()
            .sink { newValue in
                XCTAssertEqual(newValue?.player2Id, "")
            }
            .store(in: &cancellables)
        
        await sut.joinGame()
    }
}
