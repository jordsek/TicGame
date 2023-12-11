//
//  TicGameApp.swift
//  TicGame
//
//  Created by Jordan Isac on 06/12/2023.
//

import SwiftUI
import Firebase

@main
struct TicGameApp: App {
    
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}
