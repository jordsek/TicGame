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
    
    @Published private var gameMode: GameMode
    @Published private var moves: [Int?] = Array(repeating: nil, count: 9)
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
        
    }
}
