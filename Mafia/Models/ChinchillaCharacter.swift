//
//  ChinchillaCharacter.swift
//  Mafia
//
//  Created by Uliana Gritchina on 02.02.2024.
//

import Foundation

struct ChinchillaCharacter: Identifiable {
    let id = UUID().uuidString
    let name: String
    let imageName: String
    let isLock: Bool
    var selectedCount: Int
    
    init(name: String, imageName: String, isLock: Bool, selectedCount: Int = 0) {
        self.name = name
        self.imageName = imageName
        self.isLock = isLock
        self.selectedCount = selectedCount
    }
}
