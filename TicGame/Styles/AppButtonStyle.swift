//
//  AppButtonStyle.swift
//  TicGame
//
//  Created by Jordan Isac on 06/12/2023.
//

import Foundation
import SwiftUI

struct AppButtonStyle: ButtonStyle{
    let color: Color
    
    init(color: Color) {
        self.color = color
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(height: 40)
            .frame().frame(maxWidth: .infinity)
            .font(.title)
            .fontWeight(.semibold)
            .padding()
            .background(color)
            .foregroundStyle(.white)
            .clipShape(Capsule())
            .opacity(configuration.isPressed ? 0.5: 1.0)
            .shadow(radius: 9)
    }
}
extension ButtonStyle where Self == AppButtonStyle{
    static func appButton(color: Color) -> AppButtonStyle {
        AppButtonStyle(color: color)
    }
}
