//
//  UserDefaultsManager.swift
//  Mafia
//
//  Created by Uliana Gritchina on 03.02.2024.
//

import Foundation

enum UserDefaultsManagerKey: String {
    case charactersSet = "characters_set"
    case backgroundImageName = "background_image_name"
}

final class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    private init() { }
    
    func saveFavoriteCharacterNames(_ names: [String]) {
        UserDefaults.standard.setValue(names, forKey: "favorite_characters")
    }
    
    func getFavoriteCharacterNames() -> [String] {
        UserDefaults.standard.stringArray(forKey: "favorite_characters") ?? []
    }
    
    func saveData(_ data: Codable, for key: UserDefaultsManagerKey) {
        if let encodedData = try? JSONEncoder().encode(data) {
            UserDefaults.standard.set(encodedData, forKey: key.rawValue)
        }
    }
    
    func getCharactersSet() -> CharacterSet {
        guard
            let data = UserDefaults.standard.data(forKey: UserDefaultsManagerKey.charactersSet.rawValue),
            let set = try? JSONDecoder().decode(CharacterSet.self, from: data)
        else { return .cartoon }
        return set
    }
    
    func getBackgroundImageName() -> String {
        guard
            let data = UserDefaults.standard.data(forKey: UserDefaultsManagerKey.backgroundImageName.rawValue),
            let imageName = try? JSONDecoder().decode(String.self, from: data)
        else { return "night" }
        return imageName
    }
}
