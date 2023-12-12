//
//  FirebaseRepository.swift
//  TicGame
//
//  Created by Jordan Isac on 11/12/2023.
//

import Foundation
import FirebaseFirestoreSwift
import Combine

public typealias EncodableIdentifiable = Encodable & Identifiable

protocol FirebaseRepositoryProtocol {
    func getDocuments<T: Codable>(from collection: FBCollectionReference, for playerId: String) async throws -> [T]?
    
    func listen<T: Codable>(from collection: FBCollectionReference, documentId: String) async throws -> AnyPublisher<T?, Error>
    
    func deleteDocument(with id: String, from collection: FBCollectionReference)
    
    func saveDocument<T: EncodableIdentifiable>(data: T, to collection: FBCollectionReference) throws
}

final class FirebaseRepository: FirebaseRepositoryProtocol {
    
    func getDocuments<T: Codable>(from collection: FBCollectionReference, for playerId: String) async throws -> [T]? {
        let snapshot = try await FirebaseReference(collection)
            .whereField(Constants.player2Id, isEqualTo: "")
            .whereField(Constants.player1Id, isNotEqualTo: "playerId").getDocuments()
        
        return snapshot.documents.compactMap { QueryDocumentSnapshot -> T? in
            return try? QueryDocumentSnapshot.data(as: T.self)
        }
    }
    
    func listen<T: Codable>(from collection: FBCollectionReference, documentId: String) async throws -> AnyPublisher<T?, Error> {
        
        let subject = PassthroughSubject<T?, Error>()
        
        let handle = FirebaseReference(collection).document(documentId).addSnapshotListener { QuerySnapshot, error in
            
            if let error = error {
                subject.send(completion: .failure(error))
                return
            }
            guard let document = QuerySnapshot else {
                subject.send(completion: .failure(AppError.badSnapshot))
                return
            }
            
            let data = try? document.data(as: T.self)
            
            subject.send(data)
        }
        
        return subject.handleEvents(receiveCancel: {
            handle.remove()
        }).eraseToAnyPublisher()
    }
    
    func deleteDocument(with id: String, from collection: FBCollectionReference) {
        FirebaseReference(collection).document(id).delete()
    }
    
    func saveDocument<T: EncodableIdentifiable>(data: T, to collection: FBCollectionReference) throws {
        let id = data.id as? String ?? UUID().uuidString
        
        try FirebaseReference(collection).document(id).setData(from: data.self)
    }
    
    
}
