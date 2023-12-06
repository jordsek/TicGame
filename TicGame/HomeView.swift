//
//  HomeView.swift
//  TicGame
//
//  Created by Jordan Isac on 06/12/2023.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            main()
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
            
            Text("Tic")
                .font(.largeTitle)
                .fontWeight(.semibold)
        }
        .foregroundStyle(.teal)
        .padding(.top, 50)
        
    }
    
    @ViewBuilder
    private func buttonView() -> some View {
        VStack(spacing: 15){
            Button {
                
            } label: {
                Text("press")
            }
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 50)
    }
}
