//
//  BoardIndicatorView.swift
//  TicGame
//
//  Created by Jordan Isac on 07/12/2023.
//

import SwiftUI

struct BoardIndicatorView: View {
    //MARK: -Properties
    
    var imageName: String
    @State private var scale = 1.5
    
    var body: some View {
        Image(systemName: imageName)
            .resizable()
            .frame(width: 40, height: 40)
            .scaledToFit()
            .foregroundStyle(.indigo)
            .scaleEffect(scale)
            .animation(.spring(), value: scale)
            .shadow(radius: 5)
            .onChange(of: imageName) { newValue in
                self.scale = 2.5
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                    self.scale = 1.5
                }
            }
    }
}

#Preview {
    BoardIndicatorView(imageName: "applelogo")
}
