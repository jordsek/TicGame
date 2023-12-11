//
//  AlertItem.swift
//  TicGame
//
//  Created by Jordan Isac on 11/12/2023.
//

import Foundation
import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    var title: Text
    var message: Text
    var buttonTitle: Text
    
    init(title: String, message: String, buttonTitle: String = AppStrings.rematch)
    {
        self.title = Text(title)
        self.message = Text(message)
        self.buttonTitle = Text(buttonTitle)
    }
}
