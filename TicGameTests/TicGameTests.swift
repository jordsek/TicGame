//
//  TicGameTests.swift
//  TicGameTests
//
//  Created by Jordan Isac on 06/12/2023.
//

import XCTest
@testable import TicGame

final class TicGameTests: XCTestCase {

    let sut = GameViewModel(gameMode: .vsHuman, onlineGameRepository: OnlineGameRepository())
    
    func test_RestGameSetsTheActivePlayerToPLayer1(){
        sut.resetGame()
        XCTAssertEqual(sut.activePlayer, .player1)
    }

    func test_RestGameSetsMoveToNineObjects(){
        sut.resetGame()
        XCTAssertEqual(sut.moves.count, 9)
    }
    
    func test_ResetGameNotificationToP1Turn(){
        sut.resetGame()
        XCTAssertEqual(sut.gameNottification, "It's \(sut.activePlayer.name)'s move")
    }
    
    func test_ProcessMovesWillShowFinishAlert() {
        for index in 0..<9 {
            sut.processMove(for: index)
        }
        
        XCTAssertEqual(sut.gameNottification, AppStrings.gameFinished)
        
    }
    
    func test_ProcessMovesWillReturnForOccupiedSqure() {
        sut.processMove(for: 0)
        sut.processMove(for: 0)
        
        XCTAssertEqual(sut.moves.compactMap {$0}.count, 1)
    }
}
