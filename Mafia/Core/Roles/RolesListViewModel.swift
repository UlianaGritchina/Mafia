//
//  CharactersListViewModel.swift
//  Mafia
//
//  Created by Uliana Gritchina on 02.02.2024.
//

import Foundation

extension CharactersList {
    
    @MainActor final class ViewModel: ObservableObject {
        
        // MARK: Variables
        
        private var allCharacters = CharactersManager.allCharacters
        
        // MARK: Published
        
        @Published var isShowCharacterDetail = false
        @Published var selectedCharacter: Role?
        @Published var selectedSet: RolesSet
        @Published var classicCharacters = CharactersManager.classicCharacters
        @Published var moreCharacters = CharactersManager.moreCharacters
        
        // MARK: Init
        
        init() {
            selectedSet = UserDefaultsManager.shared.getCharactersSet()
        }
        
        // MARK: Public methods
        
        func showCharacterDetail(_ character: Role) {
            selectedCharacter = character
            isShowCharacterDetail = true
        }
        
        func closeCharacterDetail() {
            selectedCharacter = nil
            isShowCharacterDetail = false
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
