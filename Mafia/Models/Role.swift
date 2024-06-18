//
//  ChinchillaCharacter.swift
//  Mafia
//
//  Created by Uliana Gritchina on 02.02.2024.
//

import Foundation

struct Role: Identifiable, Equatable {
    let id = UUID().uuidString
    let name: String
    let imageName: String
    let description: String 
    var selectedCount: Int

    init(name: String, imageName: String, selectedCount: Int = 0) {
        description = "\(imageName)\("_des")".localised
        self.name = name.localised
        self.selectedCount = selectedCount
        let type = UserDefaultsManager.shared.getCharactersSet()
        self.imageName = imageName + type.rawValue
    }
}
