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
                    ScrollView {
                        switch viewModel.selectedCharactersType {
                        case .all:
                            allCharacters
                        case .favourite:
                            favouriteCharacters
                        }
                    }
                    .transition(.move(edge: .trailing))
                } else {
                    PlayersList(players: $viewModel.players)
                        .transition(.move(edge: .leading))
                }
                bottomBar
            }
            .background(BackgroundImage())
            .navigationTitle(viewModel.navigationTitle)
            .navigationBarItems(trailing: closeButton)
            .ignoresSafeArea(.keyboard)
            .animation(.smooth, value: viewModel.isShowRoles)
            .fullScreenCover(isPresented: $viewModel.isStart, content: {
                GameResultView(
                    characters: viewModel.getCharactersForGame(),
                    players: viewModel.playersForGame
                )
            })
            .alert(isPresented: $viewModel.isShowErrorAlert, content: { getNoPlayersAlert() })
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    GameView()
}

extension GameView {
    
    private var closeButton: some View {
        Button(action: { presentationMode.wrappedValue.dismiss() }) {
            Image(systemName: "xmark")
        }
    }
    
    private var allCharacters: some View {
        ScrollView {
            VStack {
                DividerHeader(title: "Base")
                
                LazyVGrid(columns: columns) {
                    ForEach(0..<viewModel.classicCharacters.count, id: \.self) { characterIndex in
                        VStack {
                            CharacterCard(character: viewModel.classicCharacters[characterIndex])
                                .shadow(
                                    color: .blue.opacity(viewModel.isSelectedCharacter(viewModel.classicCharacters[characterIndex]) ? 0.7 : 0),
                                    radius: 5
                                )
                            CountStepper(
                                count: $viewModel.classicCharacters[characterIndex].selectedCount,
                                range: 0...viewModel.freePlaces(for: viewModel.classicCharacters[characterIndex])
                            )
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
    
    private var bottomBar: some View {
        HStack {
            if viewModel.isShowRoles {
                rolesBottomBar
            } else {
                playersBottomBar
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 6)
        .background(.ultraThinMaterial)
        .animation(.none, value: viewModel.isShowRoles)
    }
    
    private var playersBottomBar: some View {
        Button(action: { viewModel.nextButtonTapped() }) {
            Text("Next")
                .font(.system(size: 25, weight: .bold, design: .serif))
        }
    }
    
    private var rolesBottomBar: some View {
        VStack {
            picker
            Divider()
            if viewModel.isShowRoles {
                HStack {
                    Button(action: { viewModel.backButtonTapped() }) {
                        Text("Back")
                            .font(.system(size: 25, weight: .bold, design: .serif))
                    }
                    .buttonStyle(GrayButtonStyle())
                    
                    Spacer()
                    
                    playersCounter
                    
                    Spacer()
                    
                    Button(action: { viewModel.startButtonTapped() }) {
                        Text("Start")
                            .font(.system(size: 25, weight: .bold, design: .serif))
                    }
                    .buttonStyle(GrayButtonStyle())
                    .disabled(!viewModel.isStartButtonActive)
                    .opacity(viewModel.isStartButtonActive ? 1 : 0.5)
                }
                .padding(.horizontal, 40)
            }
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
    
    private var playersCounter: some View {
        Text("\(viewModel.selectedCharactersCount) : \(viewModel.playersForGame.count)")
            .font(.system(size: 20, weight: .bold, design: .serif))
            .foregroundStyle(viewModel.isStartButtonActive ? .green : .white)
    }
    
    private func getNoPlayersAlert() -> Alert {
        Alert(title: Text("No players"))
    }
}
