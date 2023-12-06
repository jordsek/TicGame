//
//  HomeView.swift
//  TicGame
//
//  Created by Jordan Isac on 06/12/2023.
//

import SwiftUI

struct HomeView: View {
    //MARK: -Properties
    @State private var gameMode: GameMode?
    var body: some View {
        VStack {
            main()
                .fullScreenCover(item: $gameMode){ mode in
                    GameView(mode: mode)
                }
        }
        
    }
}

#Preview {
    HomeView()
}

extension HomeView {
     @ViewBuilder
    private func main() -> some View {
        VStack{
            titleView()
            Spacer()
            buttonView()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.init(red: 0.91, green: 0.89, blue: 0.90))
    }
        
    
    @ViewBuilder
    private func titleView() -> some View {
        VStack(spacing: 20){
            Image(systemName: "number")
                .renderingMode(.original)
                .resizable()
                .frame(width: 180, height: 180)
            
            Text(AppStrings.appName)
                .font(.largeTitle)
                .fontWeight(.semibold)
        }
        .foregroundStyle(.teal)
        .padding(.top, 50)
        
    }
    
    @ViewBuilder
    private func buttonView() -> some View {
        VStack(spacing: 15){
            ForEach(GameMode.allCases, id: \.self){ mode in
                Button{
                    self.gameMode = mode
                }label: {
                    Text(mode.name)
                }
                .buttonStyle(.appButton(color: mode.color))
            }
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 50)
    }
}
