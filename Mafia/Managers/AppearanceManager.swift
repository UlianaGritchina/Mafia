//
//  AppearanceManager.swift
//  Mafia
//
//  Created by Ульяна Гритчина on 18.06.2024.
//

import Foundation

final class AppearanceManager: ObservableObject {
    @Published var backgroundImageName = "nightMoonCity"
    
    init() {
        backgroundImageName = UserDefaultsManager.shared.getBackgroundImageName()
    }
    
    func updateBackgroundImage(with image: String) {
        backgroundImageName = image
    }
}
