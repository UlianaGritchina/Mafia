//
//  GameResultView.swift
//  Mafia
//
//  Created by Ульяна Гритчина on 18.02.2024.
//

import SwiftUI

struct GameResultView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var characters: [Role]
    @State private var currentContentIndex = 0
    @State private var isShowAllPlayers = false
    
    let players: [String]
    
    
    
    var body: some View {
        NavigationView {
            VStack {
                cardsTabView
                HStack(spacing: 15) {
                    Button(action: { presentationMode.wrappedValue.dismiss() }) {
                        Text("Complete")
                            .font(.system(size: 20, weight: .bold, design: .serif))
                            .frame(maxWidth: .infinity)
                            .frame(height: 45)
                    }
                    .buttonStyle(GrayButtonStyle())
                    
                    Button(action: { shuffle()  }) {
                        Text("Shuffle")
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
            .sheet(isPresented: $isShowAllPlayers) { AllPlayersView(players: players, roles: characters) }
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("All") { isShowAllPlayers.toggle()  }
                }
            })
        }
    }
    
    func shuffle() {
        characters = characters.shuffled()
        withAnimation {
            currentContentIndex = 0
        }
        HapticManager.instance.impact(style: .soft)
    }
}


#Preview {
    GameResultView(
        characters: [
            Role(name: "Mafia", imageName: "Mafia"),
            Role(name: "Mafia", imageName: "Mafia")],
        players: ["Uliana", "Max", "Kirill"]
    )
}

extension GameResultView {
    
    @ViewBuilder private var cardsScroll: some View {
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
    }
    
    private var cardsTabView: some View {
        TabView(selection: $currentContentIndex) {
            ForEach(0..<players.count, id: \.self) { index in
                VStack {
                    PlayerRoleCard(
                        role: characters[index],
                        playerName: players[index]
                    )
                }
                .id(index)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .automatic))
    }
    
    private var replayButton: some View {
        Button(action: {
            characters = characters.shuffled()
        }) {
            Image(systemName: "arrow.circlepath")
        }
    }
}
