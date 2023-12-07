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
    
    @Published private(set) var gameMode: GameMode
    
    init(gameMode: GameMode) {
        self.gameMode = gameMode
    }
}
