//
//  CharacterDetailViewModel.swift
//  Mafia
//
//  Created by Uliana Gritchina on 03.02.2024.
//

import Foundation

extension RoleDetailView {
    @MainActor final class ViewModel: ObservableObject {
        
        // MARK: Constants
        
        let character: Role
        
        // MARK: Init
        
        init(character: Role) {
            self.character = character
        }
    }
}
