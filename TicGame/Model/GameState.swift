//
//  GameState.swift
//  TicGame
//
//  Created by Jordan Isac on 11/12/2023.
//

import Foundation

enum GameState {
    case finished, draw, waitingForPlayer, quit
    
    var name: String{
        switch self {
        case .finished:
            return AppStrings.gameFinished
        case .draw:
            return AppStrings.draw
        case .waitingForPlayer:
            return AppStrings.waitingForPLayer
        case .quit:
            return AppStrings.playerLeft
        }
    }
}
