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
        VStack {
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
                .preferredColorScheme(.dark)
            }
            HStack(spacing: 15) {
                Button(action: {
                    characters = characters.shuffled()
                    HapticManager.instance.notification(type: .success)
                }) {
                    Text("Shuffle")
                        .font(.system(size: 20, weight: .bold, design: .serif))
                        .frame(maxWidth: .infinity)
                        .frame(height: 45)
                }
                .buttonStyle(GrayButtonStyle())
                
                Button(action: { presentationMode.wrappedValue.dismiss() }) {
                    Text("Complite")
                        .font(.system(size: 20, weight: .bold, design: .serif))
                        .frame(maxWidth: .infinity)
                        .frame(height: 45)
                }
                .buttonStyle(GrayButtonStyle())
            }
            .padding()
            .padding(.bottom)
        }
        .background(BackgroundImage())
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
