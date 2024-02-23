//
//  CharactersListViewModel.swift
//  Mafia
//
//  Created by Uliana Gritchina on 02.02.2024.
//

import Foundation
enum CharactersType {
    case all
    case favourite
}

extension CharactersList {
    
    
    @MainActor final class ViewModel: ObservableObject {
        
        @Published var selectedCharactersType: CharactersType = .all
        @Published var isShowCharacterDetail = false
        @Published var selectedCharacter: Role?
        @Published var favouriteCharacters: [Role] = []
        
        private let allCharacters = CharactersManager.allCharacters
        let classicCharacters = CharactersManager.classicCharacters
        let moreCharacters = CharactersManager.moreCharacters
        
        init() {
            updateFavoriteCharacters()
        }
        
        func updateFavoriteCharacters() {
            let characterNames = UserDefaultsManager.shared.getFavoriteCharacterNames()
            favouriteCharacters = characterNames.compactMap({ name in
                allCharacters.first(where: { $0.name == name })
            })
        }
        
        func showCharacterDetail(_ character: Role) {
            selectedCharacter = character
            isShowCharacterDetail = true
        }
        
        func closeCharacterDetail() {
            selectedCharacter = nil
            isShowCharacterDetail = false
            updateFavoriteCharacters()
        }
    }
}
