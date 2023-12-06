//
//  GameView.swift
//  TicGame
//
//  Created by Jordan Isac on 06/12/2023.
//

import SwiftUI

struct GameView: View {
    //MARK: -properties
    var mode: GameMode
    
    var body: some View {
        Text("Game \(mode.name)")
    }
}

#Preview {
    GameView(mode: GameMode.online)
}
