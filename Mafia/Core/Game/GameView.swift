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
            .navigationBarItems(trailing: resetRolesButton)
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
    
    @ViewBuilder  private var resetRolesButton: some View {
        if viewModel.isShowRoles {
            Button("Reset") {
                viewModel.resetCharacters()
            }
        }
    }
    
    private var allCharacters: some View {
        ScrollView {
            VStack {
                DividerHeader(title: "Base")
                
                LazyVGrid(columns: columns) {
                    ForEach(0..<viewModel.classicCharacters.count, id: \.self) { characterIndex in
                        VStack {
                            GameRoleCard(
                                character: $viewModel.classicCharacters[characterIndex],
                                isSelected: viewModel.isSelectedCharacter(viewModel.classicCharacters[characterIndex]),
                                rangeLimit: viewModel.freePlaces(for: viewModel.classicCharacters[characterIndex])
                            )
                            .padding(.horizontal, 5)
                            .padding(.top, 5)
                        }
                    }
                    .padding()
                }
                
                DividerHeader(title: "More")
                
                LazyVGrid(columns: columns) {
                    ForEach(0..<viewModel.moreCharacters.count, id: \.self) { characterIndex in
                        Button(action: {  }) {
                            VStack {
                                GameRoleCard(
                                    character: $viewModel.moreCharacters[characterIndex],
                                    isSelected: viewModel.isSelectedCharacter(viewModel.moreCharacters[characterIndex]),
                                    rangeLimit: viewModel.freePlaces(for: viewModel.moreCharacters[characterIndex])
                                )
                                .padding(.horizontal, 5)
                                .padding(.top, 5)
                            }
                        }
                        .buttonStyle(ScaleButtonStyle())
                    }
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
                    ForEach(0..<viewModel.favouriteCharacters.count, id: \.self) { characterIndex in
                        Button(action: { }) {
                            GameRoleCard(
                                character: $viewModel.favouriteCharacters[characterIndex],
                                isSelected: viewModel.isSelectedCharacter(viewModel.favouriteCharacters[characterIndex]),
                                rangeLimit: viewModel.freePlaces(for: viewModel.favouriteCharacters[characterIndex])
                            )
                            .padding(.horizontal, 5)
                            .padding(.top, 5)
                        }
                    }
                    .padding()
                }
            }
            .padding(.bottom, 50)
        }
    }
    
    private var bottomBar: some View {
        Rectangle()
            .opacity(0)
            .frame(maxWidth: .infinity)
            .frame(height: UIScreen.main.bounds.height / 10)
            .background(.ultraThinMaterial)
            .overlay {
                HStack {
                    if viewModel.isShowRoles {
                        rolesBottomBar
                            .transition(.move(edge: .trailing))
                    } else {
                        playersBottomBar
                            .transition(.move(edge: .leading))
                    }
                }
            }
    }
    
    private var playersBottomBar: some View {
        HStack(spacing: 15) {
            Button(action: { presentationMode.wrappedValue.dismiss() }) {
                Text("Exit")
                    .font(.system(size: 25, weight: .bold, design: .serif))
                    .frame(maxWidth: .infinity)
                    .frame(height: 35)
            }
            .buttonStyle(GrayButtonStyle())
            
            Spacer()
            
            Button(action: { viewModel.nextButtonTapped() }) {
                Text("Next")
                    .font(.system(size: 25, weight: .bold, design: .serif))
                    .frame(maxWidth: .infinity)
                    .frame(height: 35)
            }
            .buttonStyle(GrayButtonStyle())
        }
        .padding()
        .padding(.bottom)
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
