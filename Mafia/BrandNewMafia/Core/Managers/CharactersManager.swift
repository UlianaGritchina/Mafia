//
//  CharactersManager.swift
//  Mafia
//
//  Created by Uliana Gritchina on 03.02.2024.
//

import Foundation

final class CharactersManager {
    static let classicCharacters: [ChinchillaCharacter] = [
        ChinchillaCharacter(name: "Mafia", imageName: "Mafia", isLock: false),
        ChinchillaCharacter(name: "Sheriff", imageName: "Sheriff", isLock: false),
        ChinchillaCharacter(name: "Doctor", imageName: "Doctor", isLock: false),
        ChinchillaCharacter(name: "Civilian", imageName: "Civilian", isLock: false),
        ChinchillaCharacter(name: "Maniac", imageName: "Maniac", isLock: false),
        ChinchillaCharacter(name: "Mistress", imageName: "Mistress", isLock: false),
        ChinchillaCharacter(name: "Game Host", imageName: "GameHost", isLock: false)
    ]
    
    static let moreCharacters: [ChinchillaCharacter] = [
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
    
    static  var allCharacters: [ChinchillaCharacter] {
        classicCharacters + moreCharacters
    }
}
