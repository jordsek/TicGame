//
//  GameMove.swift
//  TicGame
//
//  Created by Jordan Isac on 08/12/2023.
//

import Foundation

struct GameMove: Codable {
    let player: Player
    let boardIndex: Int
    
    var indicator: String {
        player == .player1 ? "xmark" : "circle"
    }
}
