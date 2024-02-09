//
//  PlayersView.swift
//  Mafia
//
//  Created by Uliana Gritchina on 03.02.2024.
//

import SwiftUI

struct GameView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = ViewModel()
    @State private var age = 0
    private let columns: [GridItem] = [
        GridItem(.adaptive(minimum: UIScreen.main.bounds.width / 3, maximum: 700))
    ]
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                if viewModel.isShowRoles {
                    VStack {
                        switch viewModel.selectedCharactersType {
                        case .all:
                            allCharacters
                        case .favourite:
                            favouriteCharacters
                        }
                    }
                } else {
                    PlayersList(players: $viewModel.players)
                }
                startButton
            }
            .background(BackgroundImage())
            .navigationTitle(viewModel.navigationTitle)
            .navigationBarItems(trailing: closeButton)
            .ignoresSafeArea(.keyboard)
            .sheet(isPresented: $viewModel.isStart, content: {
                PlayerRoleCard(
                    role: ChinchillaCharacter(
                        name: "Mafia",
                        imageName: "Mafia",
                        isLock: false),
                    playerName: "Uliana"
                )
            })
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    GameView()
}

extension GameView {
    
    private var startButton: some View {
        HStack {
            if viewModel.isShowRoles {
                VStack {
                    picker
                    HStack {
                        Spacer()
                        Button(action: { viewModel.backButtonTapped() }) {
                            Text("Back")
                                .font(.system(size: 25, weight: .bold, design: .serif))
                                .padding(.bottom, 8)
                        }
                        Spacer()
                        Button(action: { viewModel.startButtonTapped() }) {
                            Text("Start")
                                .font(.system(size: 25, weight: .bold, design: .serif))
                                .padding(.bottom, 8)
                        }
                        Spacer()
                    }
                }
            } else {
                Button(action: { viewModel.nextButtonTapped() }) {
                    Text("Next")
                        .font(.system(size: 25, weight: .bold, design: .serif))
                        .padding(.bottom, 8)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 6)
        .background(.ultraThinMaterial)
    }
    
    private var closeButton: some View {
        Button(action: {presentationMode.wrappedValue.dismiss()}) {
            Image(systemName: "xmark")
        }
    }
    
    private var allCharacters: some View {
        ScrollView {
            VStack {
                DividerHeader(title: "Base")
                
                LazyVGrid(columns: columns) {
                    ForEach(viewModel.classicCharacters) { character in
                        VStack {
                            CharacterCard(character: character)
                            CountStepper(count: $age, range: 0...5)
                                .padding(.horizontal, 5)
                                .padding(.top, 5)
                        }
                    }
                    .padding()
                }
                
                DividerHeader(title: "More")
                
                LazyVGrid(columns: columns) {
                    ForEach(viewModel.moreCharacters) { character in
                        Button(action: {  }) {
                            CharacterCard(character: character)
                        }
                        .buttonStyle(ScaleButtonStyle())
                    }
                    .padding()
                }
            }
            .padding(.bottom, 50)
        }
    }
    
    private var favouriteCharacters: some View {
        ScrollView {
            VStack {
                DividerHeader(title: "Favourite")
                
                LazyVGrid(columns: columns) {
                    ForEach(viewModel.favouriteCharacters) { character in
                        Button(action: { }) {
                            CharacterCard(character: character)
                        }
                    }
                    .padding()
                }
            }
            .padding(.bottom, 50)
        }
    }
    
    private var picker: some View {
        Picker(selection: $viewModel.selectedCharactersType, label: Text("Picker")) {
            Text("All").tag(CharactersType.all)
            Text("Favourite").tag(CharactersType.favourite)
        }
        .pickerStyle(.segmented)
        .padding(.horizontal)
        .padding(.vertical, 5)
    }
}
