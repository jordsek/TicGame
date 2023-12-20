//
//  MockFirebaseRepository.swift
//  TicGame
//
//  Created by Jordan Isac on 20/12/2023.
//

import Foundation
import Combine

final class MockFirebaseRepository: FirebaseRepositoryProtocol {
    
    let dummyGame = Game(id: "MocID",
                         player1Id: "P1ID",
                         player2Id: "P2ID",
                         player1Score: 3,
                         player2Score: 4,
                         activePlayerId: "P1ID",
                         winningPLayerId: "",
                         moves: Array(repeating: nil, count: 9))
    
    var returnNil = false
    
    init(shouldReturnNil: Bool = false){
        returnNil = shouldReturnNil
    }
    
    func getDocuments<T>(from collection: FBCollectionReference, for playerId: String) async throws -> [T]? where T : Decodable, T : Encodable {
        
        returnNil ? nil : [dummyGame] as? [T]
    }
    
    func listen<T>(from collection: FBCollectionReference, documentId: String) async throws -> AnyPublisher<T?, Error> where T : Decodable, T : Encodable {
        
        let subject = PassthroughSubject<T?, Error>()
        
        subject.send(dummyGame as? T)
        return subject.eraseToAnyPublisher()
    }
    
    func deleteDocument(with id: String, from collection: FBCollectionReference) {
        
    }
    
    func saveDocument<T>(data: T, to collection: FBCollectionReference) throws where T : Encodable, T : Identifiable {
        
    }
    
    
}
