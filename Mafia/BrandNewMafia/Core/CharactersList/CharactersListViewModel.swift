//
//  CharactersListViewModel.swift
//  Mafia
//
//  Created by Uliana Gritchina on 02.02.2024.
//

import Foundation

extension CharactersList {
    
    enum CharactersType {
        case all
        case favourite
    }
    
    @MainActor final class ViewModel: ObservableObject {
        
        @Published var selectedCharactersType: CharactersType = .all
        @Published var favouriteCharacters: [ChinchillaCharacter] = []
        @Published var isShowCharacterDetail = false
        @Published var selectedCharacter: ChinchillaCharacter?
        
        let classicCharacters = CharactersManager.shared.classicCharacters
        let moreCharacters = CharactersManager.shared.moreCharacters
        
        func showCharacterDetail(_ character: ChinchillaCharacter) {
            selectedCharacter = character
            isShowCharacterDetail = true
        }
        
        func closeCharacterDetail() {
            selectedCharacter = nil
            isShowCharacterDetail = false
        }
    }
    
}
