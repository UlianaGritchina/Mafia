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
        @Published var isShowErrorAlert = false
        @Published var selectedCharactersType: CharactersType = .all
        @Published var favouriteCharacters: [Role] = []
        @Published var classicCharacters = CharactersManager.classicCharacters
        @Published var moreCharacters = CharactersManager.moreCharacters
        
        init() {
            updateFavoriteCharacters()
        }
        
        var isStartButtonActive: Bool {
            playersForGame.count == selectedCharactersCount
        }
        
        var selectedCharacters: [Role] {
            var selected: [Role] = []
            let _ = classicCharacters.map { character in
                if character.selectedCount > 0 {
                    selected.append(character)
                }
            }
            let _ = moreCharacters.map { character in
                if character.selectedCount > 0 {
                    selected.append(character)
                }
            }
            let _ = favouriteCharacters.map { character in
                if character.selectedCount > 0 {
                    selected.append(character)
                }
            }
            return selected.shuffled()
        }
        
        var selectedCharactersCount: Int {
            var count = 0
            let _ = selectedCharacters.map { character in
                count += character.selectedCount
            }
            return count
        }
        
        var playersForGame: [String] {
            var names: [String] = []
            let _ = players.map { player in
                if !player.isEmpty {
                    names.append(player)
                }
            }
            return names
        }
        
        var freePositionCount: Int {
            playersForGame.count - selectedCharactersCount
        }
        
        var navigationTitle: String {
            isShowRoles ? "Roles".localised : "Players".localised
        }
        
        func nextButtonTapped() {
            if playersForGame.isEmpty {
                isShowErrorAlert = true
                HapticManager.instance.notification(type: .error)
            } else {
                isShowRoles = true
            }
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
        
        func getCharactersForGame() -> [Role] {
            var charactersForGame: [Role] = []
            let _ = selectedCharacters.compactMap { character in
                charactersForGame += Array(repeating: character, count: character.selectedCount)
            }
            return charactersForGame.shuffled()
        }
        
        func resetCharacters() {
            classicCharacters = CharactersManager.classicCharacters
            moreCharacters = CharactersManager.moreCharacters
            updateFavoriteCharacters()
        }
        
        func freePlaces(for character: Role) -> Int {
            let character = selectedCharacters.first(where: { $0.name == character.name})
            return playersForGame.count - selectedCharactersCount + (character?.selectedCount ?? 0)
        }
        
        func isSelectedCharacter(_ character: Role) -> Bool {
            selectedCharacters.contains(where: { $0.name == character.name })
        }
    }
}
