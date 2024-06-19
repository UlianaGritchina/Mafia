//
//  RolesSet.swift
//  Mafia
//
//  Created by Ульяна Гритчина on 19.06.2024.
//

import Foundation

enum RolesSet: String, Codable, CaseIterable {
    case cartoon = "_mult"
    case chinchillas = "_chin"
    case real = "_real"
    
    var title: String {
        switch self {
        case .cartoon:
            "Cartoon"
        case .chinchillas:
            "Chinchillas"
        case .real:
            "Real"
        }
    }
}
