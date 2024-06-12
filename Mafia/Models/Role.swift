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
    var selectedCount: Int
    
    init(name: String, imageName: String, selectedCount: Int = 0) {
        self.name = name
        self.imageName = imageName
        self.selectedCount = selectedCount
    }
}
