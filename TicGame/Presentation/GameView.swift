//
//  GameView.swift
//  TicGame
//
//  Created by Jordan Isac on 06/12/2023.
//

import SwiftUI

struct GameView: View {
    //MARK: -properties
    @Environment(\.dismiss) var dismiss
   
    
    @ObservedObject var viewModel: GameViewModel
    
    var body: some View {
     main()
            .alert(isPresented: $viewModel.showAlert){
                Alert(title: viewModel.alertItem!.title, message: viewModel.alertItem!.message, dismissButton: .default(viewModel.alertItem!.buttonTitle){
                    viewModel.resetGame()
                })
            }
    }
}

#Preview {
    GameView(viewModel: GameViewModel(gameMode: .vsHuman, onlineGameRepository: OnlineGameRepository()))
    
}

extension GameView {
    @ViewBuilder
    private func main() -> some View{
        GeometryReader { geometry in
            
            VStack {
                closeButton()
                scoreView()
                Spacer()
                gameStatus()
                Spacer()
                
                gameBoard(geometry: geometry)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, 16)
            .background(Color.indigo)
        }
    }
    @ViewBuilder
    private func closeButton() -> some View{
        HStack{
            Spacer()
            Button {
                viewModel.quitTheGame()
                dismiss()
            } label: {
                Text(AppStrings.exit)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.red)
            }
            .frame(width: 80, height: 40)
            .background(RoundedRectangle(cornerRadius: 10)
                .fill(.white))
        }
        .padding(.bottom, 20)
    }
    
    @ViewBuilder
    private func scoreView() -> some View {
        HStack{
            Text("\(viewModel.player1Name): \(viewModel.player1Score)")
            Spacer()
            Text("\(viewModel.player2Name): \(viewModel.player2Score)")
        }
        .foregroundStyle(.white)
        .font(.title2)
        .fontWeight(.semibold)
    }
    
    @ViewBuilder
    private func gameStatus() -> some View {
        VStack{
            VStack {
                Text(viewModel.gameNottification)
                    .font(.title2)
                if viewModel.showLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .tint(.white)
                }
            }
            .foregroundStyle(.white)
            //.background(Color.pink)
        }
    }
    
    @ViewBuilder
    private func gameBoard(geometry: GeometryProxy) -> some View {
        VStack {
            LazyVGrid(columns: viewModel.columns, spacing: 10){
                ForEach(0..<9) { index in
                    ZStack{
                        BoardCircleView(geometry: geometry)
                        BoardIndicatorView(imageName: viewModel.moves[index]?.indicator ?? "")
                    }
                    .onTapGesture {
                        viewModel.processMove(for: index)
                    }
                }
            }
        }
        .padding(.bottom, 10)
        .disabled(viewModel.isGameBoardDisbled)
    }
}
