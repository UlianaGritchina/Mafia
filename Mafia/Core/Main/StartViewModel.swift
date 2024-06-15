//
//  StartViewModel.swift
//  Mafia
//
//  Created by Uliana Gritchina on 02.02.2024.
//

import Foundation

extension MainView {
    @MainActor final class ViewModel: ObservableObject {
        
        //MARK: - Consents
        
        let characters = CharactersManager.allCharacters.shuffled()
        @Published var charactersSet = UserDefaultsManager.shared.getCharactersSet()
        
        //MARK: - Published
        
        @Published var isShowCharactersView = false
        @Published var isPlay = false
        
        //MARK: - Public Methods
        
        func showCharacters() {
            isShowCharactersView = true
        }
        
        func playButtonTapped() {
            isPlay = true
        }
        
        func updateCharactersSet() {
            charactersSet = UserDefaultsManager.shared.getCharactersSet()
        }
    }
}
