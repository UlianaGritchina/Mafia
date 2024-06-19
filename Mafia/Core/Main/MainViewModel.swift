//
//  StartViewModel.swift
//  Mafia
//
//  Created by Uliana Gritchina on 02.02.2024.
//

import Foundation

extension MainView {
    @MainActor final class ViewModel: ObservableObject {
        
        // MARK: Constants
        
        let characters = CharactersManager.allCharacters.shuffled()
        
        // MARK: Published
        
        @Published var charactersSet = UserDefaultsManager.shared.getCharactersSet()
        @Published var isShowCharactersView = false
        @Published var isPlay = false
        @Published var isShowSettings = false
        
        // MARK: Public Methods
        
        func showCharacters() {
            isShowCharactersView = true
        }
        
        func playButtonTapped() {
            isPlay = true
        }
        
        func updateCharactersSet() {
            charactersSet = UserDefaultsManager.shared.getCharactersSet()
        }
        
        func openSettings() {
            isShowSettings = true
        }
    }
}
