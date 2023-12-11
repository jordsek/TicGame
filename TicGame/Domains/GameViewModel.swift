//
//  GameViewModel.swift
//  TicGame
//
//  Created by Jordan Isac on 07/12/2023.
//

import SwiftUI
import Combine

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
    @Published private(set) var gameNottification = ""
    @Published private(set) var activePlayer: Player = .player1
    @Published private(set) var alertItem: AlertItem?
    @Published private(set) var isGameBoardDisbled = false
    
    @Published private var players: [Player]
    @Published var showAlert = false
    
    
    
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
        gameNottification = "It's \(activePlayer.name)'s move"
        observeData()
    }
    
    private func observeData() {
        $players
            .map { $0.first?.name ?? ""}
            .assign(to: &$player1Name)
        
        $players
            .map { $0.last?.name ?? ""}
            .assign(to: &$player2Name)
    }
    
    func processMove(for position: Int){
        if isSquareOccupied(in: moves, for: position){ return }
        
        moves[position] = GameMove(player: activePlayer, boardIndex: position)
        
        
        //Check for win
        if checkIfWinCondition(in: moves) {
            //show alert to user
            showAlert(for: .finished)
            //increase the score of the winner
            increaseScore()
            return
        }
        //check for draw
        if checkIfDraw(in: moves) {
            //show alert to user
            showAlert(for: .draw)
            return
        }
        activePlayer = players.first(where: { $0 != activePlayer})!
        
        if gameMode == .vsCPU && activePlayer == .cpu {
            //cpu make a move
            isGameBoardDisbled = true
            computerMove()
        }
        gameNottification = "It's \(activePlayer.name)'s move"

        //continue
    }
    
    private func computerMove() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8 ){ [self] in
            processMove(for: getAIMovePostion(in: moves))
            isGameBoardDisbled = false
        }
    }
    
    private func getAIMovePostion(in moves: [GameMove?]) -> Int {
        let centerSquare = 4
        //if can win, then take it
        let computerMoves = moves.compactMap { $0 }.filter { $0.player == .cpu }
        let computerPositions = Set(computerMoves.map { $0.boardIndex })
        
        if let position = getTheWinningSpot(for: computerPositions){
            return position
        }
        //block player
        let humanMoves = moves.compactMap { $0 }.filter { $0.player == .player1 }
        let humanPositions = Set(humanMoves.map { $0.boardIndex })
        
        if let postions = getTheWinningSpot(for: humanPositions){
            return postions
        }
        
        //take the middle
        if !isSquareOccupied(in: moves, for: centerSquare) {return centerSquare }
        
        //take random spot
        var movePositions = Int.random(in: 0..<9)
        while isSquareOccupied(in: moves, for: movePositions){
            movePositions = Int.random(in: 0..<9)
        }
        
        return movePositions
    }
    
    private func getTheWinningSpot(for positions: Set<Int>) -> Int? {
        for pattern in winPatterns {
            let winPositions = pattern.subtracting(positions)
            
            if winPositions.count == 1 && !isSquareOccupied(in: moves, for: winPositions.first!){
                return winPositions.first!
            }
        }
        return nil
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
        
        for pattern in winPatterns where pattern.isSubset(of: playerPostions) { return true }
        return false
    }
    
    private func increaseScore() {
        if activePlayer == .player1 {
            player1Score += 1
        } else {
            player2Score += 1
        }
    }
    
    private func showAlert(for state: GameState) {
        gameNottification = state.name
        
        switch state {
        case .finished, .draw, .waitingForPlayer:
            let title = state == .finished ? "\(activePlayer.name) has won" : state.name
            alertItem = AlertItem(title: title, message: AppStrings.tryRematch)
        case .quit:
            let title = state.name
            alertItem = AlertItem(title: title, message: "", buttonTitle: "Ok")
            isGameBoardDisbled = true
        }
        
        showAlert = true
    }
    
    func resetGame() {
        activePlayer = .player1
        moves = Array(repeating: nil, count: 9)
        gameNottification = "It's \(activePlayer.name)'s move"
    }
}
