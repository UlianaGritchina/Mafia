//
//  UserDefaultsManager.swift
//  Mafia
//
//  Created by Uliana Gritchina on 03.02.2024.
//

import Foundation

extension UserDefaultsManager {
    
    func saveFavoriteCharacterNames(_ names: [String]) {
        UserDefaults.standard.setValue(names, forKey: "favorite_characters")
    }
    
    func getFavoriteCharacterNames() -> [String] {
        UserDefaults.standard.stringArray(forKey: "favorite_characters") ?? []
    }
}
