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
        
        let classicCharacters = [
            ChinchillaCharacter(name: "Mafia", imageName: "Mafia", isLock: false),
            ChinchillaCharacter(name: "Sheriff", imageName: "Sheriff", isLock: false),
            ChinchillaCharacter(name: "Doctor", imageName: "Doctor", isLock: false),
            ChinchillaCharacter(name: "Civilian", imageName: "Civilian", isLock: false),
            ChinchillaCharacter(name: "Maniac", imageName: "Maniac", isLock: false),
            ChinchillaCharacter(name: "Mistress", imageName: "Mistress", isLock: false),
            ChinchillaCharacter(name: "Game Host", imageName: "GameHost", isLock: false)
        ]
        
        let moreCharacters = [
            ChinchillaCharacter(name: "Don", imageName: "Don", isLock: false),
            ChinchillaCharacter(name: "Detective", imageName: "Detective", isLock: false),
            ChinchillaCharacter(name: "Werewolf", imageName: "Werewolf", isLock: false),
            ChinchillaCharacter(name: "Agent", imageName: "Agent", isLock: true),
            ChinchillaCharacter(name: "God Father", imageName: "GodFather", isLock: true),
            ChinchillaCharacter(name: "Judge", imageName: "Judge", isLock: false),
            ChinchillaCharacter(name: "Ninja", imageName: "Ninja", isLock: true),
            ChinchillaCharacter(name: "Advocate", imageName: "Advocate", isLock: false),
            ChinchillaCharacter(name: "Patrol", imageName: "Patrol", isLock: false),
            ChinchillaCharacter(name: "Thief", imageName: "Thief", isLock: true),
            ChinchillaCharacter(name: "Yakuza", imageName: "Yakuza", isLock: false)
        ]
        
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
