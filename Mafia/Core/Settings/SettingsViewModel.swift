//
//  SettingsViewModel.swift
//  Mafia
//
//  Created by Ульяна Гритчина on 18.06.2024.
//

import Foundation

extension SettingsView {
    @MainActor final  class ViewModel: ObservableObject {
        
        // MARK: Constants
        
        private let userDefaultsManager = UserDefaultsManager.shared
        
        let images = ["night", "evening", "day"]
        let writeReviewURL = URL(string: "https://apps.apple.com/app/mafia-gang/id1638964730?action=write-review")!
        
        // MARK: Published
        
        @Published var selectedImage: String
        
        // MARK: Init
        
        init() {
            selectedImage = userDefaultsManager.getBackgroundImageName()
        }
        
        // MARK: Public methods
        
        func selectImage(_ image: String) {
            selectedImage = image
            userDefaultsManager.saveData(image, for: .backgroundImageName)
        }
    }
}
