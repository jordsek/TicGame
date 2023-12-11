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
    func getDocuments<T: Codable>(from collection: FBCollectionReference, for playerId: String) -> [T]?
    
    func listen<T: Codable>(from collection: FBCollectionReference, documentId: String) async throws -> AnyPublisher<T?, Error>
    
    func deleteDocument(with id: String, from collection: FBCollectionReference)
    
    func saveDocument<T: EncodableIdentifiable>(data: T, to collection: FBCollectionReference) throws
}

final class FirebaseRepository: FirebaseRepositoryProtocol {
    func getDocuments<T: Codable>(from collection: FBCollectionReference, for playerId: String) -> [T]? {
        <#code#>
    }
    
    func listen<T: Codable>(from collection: FBCollectionReference, documentId: String) async throws -> AnyPublisher<T?, Error> {
        <#code#>
    }
    
    func deleteDocument(with id: String, from collection: FBCollectionReference) {
        <#code#>
    }
    
    func saveDocument<T: EncodableIdentifiable>(data: T, to collection: FBCollectionReference) throws {
        <#code#>
    }
    
    
}
