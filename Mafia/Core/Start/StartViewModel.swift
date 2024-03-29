//
//  StartViewModel.swift
//  Mafia
//
//  Created by Uliana Gritchina on 02.02.2024.
//

import Foundation

extension StartView {
    @MainActor final class ViewModel: ObservableObject {
        
        //MARK: - Consents
        
        let characters = CharactersManager.allCharacters.shuffled()
        
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
    }
}
