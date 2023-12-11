//
//  FBCollectionReference.swift
//  TicGame
//
//  Created by Jordan Isac on 11/12/2023.
//

import Foundation
import Firebase

enum FBCollectionReference: String {
    case Game
}

func FirebaseReference(_ reference: FBCollectionReference) -> CollectionReference {
    Firestore.firestore().collection(reference.rawValue)
}
