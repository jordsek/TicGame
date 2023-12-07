//
//  BoardCircleView.swift
//  TicGame
//
//  Created by Jordan Isac on 07/12/2023.
//

import SwiftUI

struct BoardCircleView: View {
    //MARK: -Properties
    var geometry: GeometryProxy
    
    @State var sizeDivider: CGFloat = 3
    @State var padding: CGFloat = 15
    var body: some View {
        Circle()
            .fill(.white)
            .frame(width: geometry.size.width / sizeDivider - padding, height: geometry.size.width / sizeDivider - padding)
    }
}

#Preview {
    GeometryReader { geometry in
        BoardCircleView(geometry: geometry)
    }
}
