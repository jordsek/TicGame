//
//  ServiceDependencies.swift
//  TicGame
//
//  Created by Jordan Isac on 12/12/2023.
//

import Foundation
import Factory

extension Container {
    var firebaseRepository: Factory<FirebaseRepositoryProtocol> {
        self { FirebaseRepository() }
            .shared
    }
}
