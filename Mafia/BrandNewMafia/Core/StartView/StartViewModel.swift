//
//  StartViewModel.swift
//  Mafia
//
//  Created by Uliana Gritchina on 02.02.2024.
//

import Foundation

extension StartView {
    @MainActor final class ViewModel: ObservableObject {
        @Published var isShowCharactersView = false
        
        func showCharacters() {
            isShowCharactersView = true
        }
    }
}
