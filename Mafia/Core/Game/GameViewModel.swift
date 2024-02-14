//
//  GameViewModel.swift
//  Mafia
//
//  Created by Uliana Gritchina on 03.02.2024.
//

import Foundation

extension GameView {
    @MainActor final class ViewModel: ObservableObject {
        
        @Published var players = Array(repeating: "", count: 30)
        @Published var isShowRoles = false
        @Published var isStart = false
        @Published var selectedCharactersType: CharactersType = .all
        @Published var favouriteCharacters: [ChinchillaCharacter] = []
        
        let classicCharacters = CharactersManager.classicCharacters
        let moreCharacters = CharactersManager.moreCharacters
        
        init() {
            updateFavoriteCharacters()
        }
        
        var navigationTitle: String {
            isShowRoles ? "Roles 0 : \(players.count)" : "Players"
        }
        
        func nextButtonTapped() {
            isShowRoles = true
        }
        
        func startButtonTapped() {
            isStart = true
        }
        
        func backButtonTapped() {
            isShowRoles = false
        }
        
        func updateFavoriteCharacters() {
            let characterNames = UserDefaultsManager.shared.getFavoriteCharacterNames()
            favouriteCharacters = characterNames.compactMap({ name in
                CharactersManager.allCharacters.first(where: { $0.name == name })
            })
        }
    }
}
