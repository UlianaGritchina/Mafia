//
//  CharacterDetailViewModel.swift
//  Mafia
//
//  Created by Uliana Gritchina on 03.02.2024.
//

import Foundation

extension CharacterDetailView {
    @MainActor final class ViewModel: ObservableObject {
        
        let character: ChinchillaCharacter
        
        private let userDefaultManager = UserDefaultsManager.shared
        @Published var favoritesCharacters = UserDefaultsManager.shared.getFavoriteCharacterNames()
        
        init(character: ChinchillaCharacter) {
            self.character = character
        }
        
        var favoriteButtonImageName: String {
            favoritesCharacters.contains(character.name) ? "star.fill" : "star"
        }
        
        func addToFavorite() {
            let characterName = character.name
            guard !favoritesCharacters.isEmpty else {
                saveFavoriteCharacterNames([characterName])
                HapticManager.instance.impact(style: .light)
                return
            }
            if favoritesCharacters.contains(characterName) {
                favoritesCharacters.removeAll(where: { $0 == characterName})
                saveFavoriteCharacterNames(favoritesCharacters)
            } else {
                favoritesCharacters.append(characterName)
                saveFavoriteCharacterNames(favoritesCharacters)
                HapticManager.instance.impact(style: .light)
            }
        }
        
        private func saveFavoriteCharacterNames(_ names: [String]) {
            userDefaultManager.saveFavoriteCharacterNames(names)
            self.favoritesCharacters = names
        }
    }
}
