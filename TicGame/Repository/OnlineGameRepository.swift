//
//  OnlineGameRepository.swift
//  TicGame
//
//  Created by Jordan Isac on 12/12/2023.
//

import Foundation
import Combine
import Factory

let localPlayerId = UUID().uuidString

final class OnlineGameRepository: ObservableObject {
    @Injected(\.firebaseRepository) private var firebaseRepository
    @Published var game: Game!
    
    private var cancellables: Set<AnyCancellable> = []
    
    func joinGame() async {
        if let gamesToJoin: Game = await getGame(){
            
            self.game = gamesToJoin
            self.game.player2Id = localPlayerId
            self.game.activePlayerId = self.game.player1Id
            
            await updateGame(self.game)
            await listenForChanges(in: self.game.id)
        } else {
            //create new
            await createNewGame()
            await listenForChanges(in: self.game.id)
        }
    }
    
    private func createNewGame() async {
        self.game = Game(id: UUID().uuidString,
                         player1Id: localPlayerId,
                         player2Id: "",
                         player1Score: 0,
                         player2Score: 0,
                         activePlayerId: localPlayerId,
                         winningPLayerId: "",
                         moves: Array(repeating: nil, count: 9))
        
        await self.updateGame(self.game)
    }
    
    
    private func listenForChanges(in gameId: String) async {
        do {
            try await firebaseRepository.listen(from: .Game, documentId: gameId)
                .sink(receiveCompletion: { completion in
                    switch completion{
                        
                    case .finished:
                        return
                    case .failure(let error):
                        print("Error", error.localizedDescription)
                    }
                }, receiveValue: { [weak self] game in
                    self?.game = game
                })
                .store(in: &cancellables)
            
        } catch {
            print("Error listening ", error.localizedDescription)
        }
    }
    
    private func getGame() async -> Game? {
        return try? await firebaseRepository.getDocuments(from: .Game, for: localPlayerId)?.first
    }
    
    func updateGame(_ gaame: Game) async {
        do {
            try firebaseRepository.saveDocument(data: game, to: .Game)
        } catch {
            print("Error updating online game", error.localizedDescription)
        }
        // call save document
      
    }
    
    func quitGame() {
        guard game != nil else { return }
        //access firebase and delete the game
        firebaseRepository.deleteDocument(with: self.game.id, from: .Game)
    }
}
