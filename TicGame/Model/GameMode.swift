//
//  GameMode.swift
//  TicGame
//
//  Created by Jordan Isac on 06/12/2023.
//

import Foundation
import SwiftUI

enum GameMode: CaseIterable, Identifiable{
    var id: Self { return self }
    
    case vsHuman, vsCPU, online
    
    var name: String {
        switch self {
            
        case .vsHuman:
            return AppStrings.vsHuman
        case .vsCPU:
            return AppStrings.vsCPu
        case .online:
            return AppStrings.online
        }
    }
    
    var color: Color {
        switch self{
            
        case .vsHuman:
            return Color.cyan
        case .vsCPU:
            return Color.mint
        case .online:
            return Color.indigo
        }
    }
}
