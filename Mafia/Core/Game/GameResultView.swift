//
//  GameResultView.swift
//  Mafia
//
//  Created by Ульяна Гритчина on 18.02.2024.
//

import SwiftUI

struct GameResultView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var characters: [ChinchillaCharacter]
    let players: [String]
    var body: some View {
        if #available(iOS 17, *) {
            ScrollView(.horizontal) {
                LazyHStack(spacing: 0) {
                    ForEach(0..<players.count, id: \.self) { index in
                        PlayerRoleCard(
                            role: characters[index],
                            playerName: players[index]
                        )
                        .scrollTransition { content, phase in content
                                .brightness(phase.isIdentity ? 0 : -0.1)
                                .scaleEffect(phase.isIdentity ? 1 : 0.9)
                        }
                    }
                }
                .scrollTargetLayout()
                .padding(.bottom)
            }
            .scrollTargetBehavior(.viewAligned)
            .safeAreaPadding(.horizontal, 40)
            .background(BackgroundImage())
            .preferredColorScheme(.dark)
        }
    }
}


#Preview {
    GameResultView(
        characters: [
            ChinchillaCharacter(name: "Mafia", imageName: "Mafia", isLock: false),
            ChinchillaCharacter(name: "Mafia", imageName: "Mafia", isLock: false)],
        players: ["Uliana", "Max", "Kirill"]
    )
}

extension GameResultView {
    
    private var closeButton: some View {
        Button(action: { presentationMode.wrappedValue.dismiss() }) {
            Image(systemName: "xmark")
        }
    }
    
    private var replayButton: some View {
        Button(action: {
            characters = characters.shuffled()
        }) {
            Image(systemName: "arrow.circlepath")
        }
    }
    
}
