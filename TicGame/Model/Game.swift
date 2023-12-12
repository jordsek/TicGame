//
//  Game.swift
//  TicGame
//
//  Created by Jordan Isac on 11/12/2023.
//

import Foundation

struct Game: Codable, Identifiable {
    let id: String
    
    var player1Id: String
    var player2Id: String
    var player1Score: Int
    var player2Score: Int
    
    var activePlayerId: String
    var winningPLayerId: String
    
    var moves: [GameMove?]
}
