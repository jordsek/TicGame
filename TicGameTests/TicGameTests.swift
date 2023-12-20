//
//  TicGameTests.swift
//  TicGameTests
//
//  Created by Jordan Isac on 06/12/2023.
//

import XCTest
@testable import TicGame

final class TicGameTests: XCTestCase {

    var sut = GameViewModel(gameMode: .vsHuman, onlineGameRepository: OnlineGameRepository())
    
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
    
    func test_Player1WinWillIncreaseTheScore() {
        XCTAssertEqual(sut.player1Score, 0)
        player1WillWin()
        XCTAssertEqual(sut.player1Score, 1)
    }
    
    func player1WillWin(){
        sut.processMove(for: 0)//p1
        sut.processMove(for: 2)//p2
        sut.processMove(for: 3)//p1
        sut.processMove(for: 5)//p2
        sut.processMove(for: 6)//p1
    }
    
    func test_Player2WinWillIncreaseTheScore() {
        XCTAssertEqual(sut.player2Score, 0)
        player2WillWin()
        XCTAssertEqual(sut.player2Score, 1)
    }
    
    func player2WillWin(){
        sut.processMove(for: 2)//p1
        sut.processMove(for: 0)//p2
        sut.processMove(for: 5)//p1
        sut.processMove(for: 3)//p2
        sut.processMove(for: 4)//p1
        sut.processMove(for: 6)//p2
    }
    
    func test_DrawWillShowNotification() {
        produceDraw()
        XCTAssertEqual(sut.gameNottification, GameState.draw.name)
    }
    
    func produceDraw(){
        sut.processMove(for: 0)//p1
        sut.processMove(for: 4)//p2
        sut.processMove(for: 2)//p1
        sut.processMove(for: 1)//p2
        sut.processMove(for: 7)//p1
        sut.processMove(for: 3)//p2
        sut.processMove(for: 5)//p1
        sut.processMove(for: 8)//p1
        sut.processMove(for: 6)//p1
    }
    
    func test_CPUWillTakeTheMiddleSpot() {
        let expectation = expectation(description: "Waiting for CPU move")
        
        sut = GameViewModel(gameMode: .vsCPU, onlineGameRepository: OnlineGameRepository())
        
        sut.processMove(for: 0)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            XCTAssertNotNil(self.sut.moves[4])
            expectation.fulfill()
        })
        waitForExpectations(timeout: 1.1)
   }
        
}
