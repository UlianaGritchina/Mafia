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
    
    @EnvironmentObject private var appearanceManager: AppearanceManager
    
    private let columns: [GridItem] = [
        GridItem(.adaptive(minimum: UIScreen.main.bounds.width / 3, maximum: 700))
    ]
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                if viewModel.isShowRoles {
                    rolesView
                } else {
                    PlayersList(players: $viewModel.players)
                        .transition(.move(edge: .leading))
                }
                bottomBar
            }
            .background(
                BackgroundImage()
                    .environmentObject(appearanceManager)
            )
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
    
    private var rolesView: some View {
        ScrollView {
            allCharacters
            bottomBar.opacity(0)
        }
        .transition(.move(edge: .trailing))
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
                            .padding(.horizontal)
                            .padding(.top, 10)
                        }
                    }
                }
                
                DividerHeader(title: "More")
                
                LazyVGrid(columns: columns) {
                    ForEach(0..<viewModel.moreCharacters.count, id: \.self) { characterIndex in
                        GameRoleCard(
                            character: $viewModel.moreCharacters[characterIndex],
                            isSelected: viewModel.isSelectedCharacter(viewModel.moreCharacters[characterIndex]),
                            rangeLimit: viewModel.freePlaces(for: viewModel.moreCharacters[characterIndex])
                        )
                        .padding(.horizontal)
                        .padding(.top, 10)
                    }
                }
            }
            .padding(.bottom, 10)
        }
    }
    
    
    private var bottomBar: some View {
        HStack {
            if viewModel.isShowRoles {
                rolesBottomBar
                    .transition(.move(edge: .trailing))
            } else {
                playersBottomBar
                    .transition(.move(edge: .leading))
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: UIScreen.main.bounds.height / 15)
        .background(.ultraThinMaterial)
    }
    
    private var playersBottomBar: some View {
        HStack(spacing: 15) {
            Button(action: { presentationMode.wrappedValue.dismiss() }) {
                Text("Exit")
                    .font(.system(size: 23, weight: .bold, design: .serif))
                    .frame(maxWidth: .infinity)
                    .frame(height: 35)
            }
            .buttonStyle(GrayButtonStyle())
            
            Spacer()
            
            Button(action: { viewModel.nextButtonTapped() }) {
                Text("Next")
                    .font(.system(size: 23, weight: .bold, design: .serif))
                    .frame(maxWidth: .infinity)
                    .frame(height: 35)
            }
            .buttonStyle(GrayButtonStyle())
        }
        .padding(.horizontal)
    }
    
    private var rolesBottomBar: some View {
        VStack {
            if viewModel.isShowRoles {
                HStack {
                    Button(action: { viewModel.backButtonTapped() }) {
                        Text("Back")
                            .font(.system(size: 25, weight: .bold, design: .serif))
                            .frame(maxWidth: .infinity)
                            .frame(height: 35)
                    }
                    .buttonStyle(GrayButtonStyle())
                    
                    Spacer()
                    
                    playersCounter
                        .padding(.horizontal)
                    
                    Spacer()
                    
                    Button(action: { viewModel.startButtonTapped() }) {
                        Text("Start")
                            .font(.system(size: 25, weight: .bold, design: .serif))
                            .frame(maxWidth: .infinity)
                            .frame(height: 35)
                    }
                    .buttonStyle(GrayButtonStyle())
                    .disabled(!viewModel.isStartButtonActive)
                    .opacity(viewModel.isStartButtonActive ? 1 : 0.5)
                }
                .padding(.horizontal)
            }
        }
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
