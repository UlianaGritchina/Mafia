//
//  PlayerRoleView.swift
//  Mafia
//
//  Created by Ульяна Гритчина on 06.02.2024.
//

import SwiftUI

struct PlayerRoleView: View {
    var body: some View {
        VStack {
            Text("Uliana")
                .font(.title)
            CharacterCard(
                character: ChinchillaCharacter(
                    name: "Mafia",
                    imageName: "Mafia",
                    isLock: false
                ),
                cardSize: .detail
            )
        }
        .padding()
        .background(Color.red.opacity(0.3))
        .cornerRadius(20)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    PlayerRoleView()
}
