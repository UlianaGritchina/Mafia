//
//  CharactersManager.swift
//  Mafia
//
//  Created by Uliana Gritchina on 03.02.2024.
//

import Foundation

enum CharacterSet: String, Codable {
    case cartoon = "_mult"
    case chinchillas = "_chin"
    case real = "_real"
}

final class CharactersManager {
    static var classicCharacters: [Role] = [
        Role(name: "Mafia", imageName: "mafia"),
        Role(name: "Sheriff", imageName: "sheriff"),
        Role(name: "Doctor", imageName: "doctor"),
        Role(name: "Civilian", imageName: "civilian"),
        Role(name: "Maniac", imageName: "maniac"),
        Role(name: "Lover", imageName: "mistress"),
        Role(name: "Game Host", imageName: "gameHost")
    ]
    
    static var moreCharacters: [Role] = [
        Role(name: "Don", imageName: "don"),
        Role(name: "Detective", imageName: "detective"),
        Role(name: "Werewolf", imageName: "werewolf"),
        Role(name: "Agent", imageName: "agent"),
        Role(name: "God Father", imageName: "godFather"),
        Role(name: "Judge", imageName: "judge"),
        Role(name: "Ninja", imageName: "ninja"),
        Role(name: "Advocate", imageName: "advocate"),
        Role(name: "Patrol", imageName: "patrol"),
        Role(name: "Thief", imageName: "thief"),
        Role(name: "Yakuza", imageName: "yakuza")
    ]
    
    static func update() {
        moreCharacters = [
            Role(name: "Don", imageName: "don"),
            Role(name: "Detective", imageName: "detective"),
            Role(name: "Werewolf", imageName: "werewolf"),
            Role(name: "Agent", imageName: "agent"),
            Role(name: "God Father", imageName: "godFather"),
            Role(name: "Judge", imageName: "judge"),
            Role(name: "Ninja", imageName: "ninja"),
            Role(name: "Advocate", imageName: "advocate"),
            Role(name: "Patrol", imageName: "patrol"),
            Role(name: "Thief", imageName: "thief"),
            Role(name: "Yakuza", imageName: "yakuza")
        ]
        
        classicCharacters = [
            Role(name: "Mafia", imageName: "mafia"),
            Role(name: "Sheriff", imageName: "sheriff"),
            Role(name: "Doctor", imageName: "doctor"),
            Role(name: "Civilian", imageName: "civilian"),
            Role(name: "Maniac", imageName: "maniac"),
            Role(name: "Lover", imageName: "mistress"),
            Role(name: "Game Host", imageName: "gameHost")
        ]
    }
    static  var allCharacters: [Role] {
        classicCharacters + moreCharacters
    }
    
}
