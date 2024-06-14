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
        @Published var selectedSet: CharacterSet
        
        private var allCharacters = CharactersManager.allCharacters
        @Published var classicCharacters = CharactersManager.classicCharacters
        @Published var moreCharacters = CharactersManager.moreCharacters
        
        init() {
            selectedSet = UserDefaultsManager.shared.getCharactersSet()
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
        
        func updateCharacters() {
            UserDefaultsManager.shared.saveData(selectedSet, for: .charactersSet)
            CharactersManager.update()
            classicCharacters = CharactersManager.classicCharacters
            moreCharacters = CharactersManager.moreCharacters
            allCharacters = CharactersManager.allCharacters
        }
    }
}
