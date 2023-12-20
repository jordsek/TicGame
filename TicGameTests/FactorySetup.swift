//
//  FactorySetup.swift
//  TicGameTests
//
//  Created by Jordan Isac on 20/12/2023.
//

import Foundation
import Factory

@testable import TicGame

extension Container {
    static func setupMocs(ShouldReturnNil: Bool = false) {
        Container.shared.firebaseRepository.register {
            MockFirebaseRepository(shouldReturnNil: ShouldReturnNil)
        }
    }
}
