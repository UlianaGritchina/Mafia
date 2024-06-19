//
//  GameRoleCard.swift
//  Mafia
//
//  Created by Ульяна Гритчина on 18.02.2024.
//

import SwiftUI

struct GameRoleCard: View {
    @Binding var character: Role
    
    let isSelected: Bool
    let rangeLimit: Int
    
    var body: some View {
        VStack(spacing: 10) {
            CharacterCard(character: character)
                .shadow(
                    color: .blue.opacity(isSelected ? 0.7 : 0),
                    radius: 5
                )
            CountStepper(
                count: $character.selectedCount,
                range: 0...rangeLimit
            )
        }
    }
}

#Preview {
    GameRoleCard(
        character: .constant(Role(
            name: "Mafia",
            imageName: "Mafia")
        ),
        isSelected: false, rangeLimit: 5
    )
}
