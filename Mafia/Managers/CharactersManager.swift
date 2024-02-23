//
//  CharactersManager.swift
//  Mafia
//
//  Created by Uliana Gritchina on 03.02.2024.
//

import Foundation

final class CharactersManager {
    static let classicCharacters: [Role] = [
        Role(name: "Mafia", imageName: "Mafia"),
        Role(name: "Sheriff", imageName: "Sheriff"),
        Role(name: "Doctor", imageName: "Doctor"),
        Role(name: "Civilian", imageName: "Civilian"),
        Role(name: "Maniac", imageName: "Maniac"),
        Role(name: "Mistress", imageName: "Mistress"),
        Role(name: "Game Host", imageName: "GameHost")
    ]
    
    static let moreCharacters: [Role] = [
        Role(name: "Don", imageName: "Don"),
        Role(name: "Detective", imageName: "Detective"),
        Role(name: "Werewolf", imageName: "Werewolf"),
        Role(name: "Agent", imageName: "Agent"),
        Role(name: "God Father", imageName: "GodFather"),
        Role(name: "Judge", imageName: "Judge"),
        Role(name: "Ninja", imageName: "Ninja"),
        Role(name: "Advocate", imageName: "Advocate"),
        Role(name: "Patrol", imageName: "Patrol"),
        Role(name: "Thief", imageName: "Thief"),
        Role(name: "Yakuza", imageName: "Yakuza")
    ]
    
    static  var allCharacters: [Role] {
        classicCharacters + moreCharacters
    }
}
