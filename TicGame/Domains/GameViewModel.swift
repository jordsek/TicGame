//
//  GameViewModel.swift
//  TicGame
//
//  Created by Jordan Isac on 07/12/2023.
//

import SwiftUI

final class GameViewModel: ObservableObject{
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    private let winPatterns: Set<Set<Int>> = [
       [0, 1, 2], [3, 4, 5], [6, 7, 8],
       [0, 3, 6], [1, 4, 7], [2, 5, 8],
       [0, 4, 8], [2, 4, 6]
    ]
    
    @Published private var gameMode: GameMode
    @Published  private(set) var moves: [GameMove?] = Array(repeating: nil, count: 9)
    @Published private(set) var player1Score = 0
    @Published private(set) var player2Score = 0
    @Published private(set) var player1Name = ""
    @Published private(set) var player2Name = ""
    @Published private(set) var activePlayer: Player = .player1
    @Published private var players: [Player]
    
    
    
    init(gameMode: GameMode) {
        self.gameMode = gameMode
        
        switch gameMode {
            
        case .vsHuman:
            self.players = [.player1, .player2]
        case .vsCPU:
            self.players = [.player1, .cpu]
        case .online:
            self.players = [.player1, .player2]
        }
    }
    
    func processMove(for position: Int){
        if isSquareOccupied(in: moves, for: position){ return }
        
        moves[position] = GameMove(player: activePlayer, boardIndex: position)
        
        activePlayer = players.first(where: { $0 != activePlayer})!
        
        //Check for win
        if checkIfWinCondition(in: moves) {
            //show alert to user
            //increase the score of the winner
            print("\(activePlayer.name) has won!")
            return
        }
        //check for draw
        if checkIfDraw(in: moves) {
            //show alert to user
            print("Its draw")
        }
        //continue
    }
    
    private func isSquareOccupied(in moves:  [GameMove?], for index: Int) -> Bool{
        moves.contains(where: {$0?.boardIndex == index})
    }
    
    private func checkIfDraw(in moves: [GameMove?]) -> Bool {
        moves.compactMap{ $0 }.count == 9
    }
    
    private func checkIfWinCondition(in moves: [GameMove?]) -> Bool {
        let playerMoves = moves.compactMap { $0 }.filter{ $0.player == activePlayer }
        let playerPostions = Set(playerMoves.map{ $0.boardIndex})
        
        print("our positions \(playerPostions)")
        for pattern in winPatterns where pattern.isSubset(of: playerPostions) { return true }
        return false
    }
}
