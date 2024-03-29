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
    
    private var rolesView: some View {
        ScrollView {
            switch viewModel.selectedCharactersType {
            case .all:
                allCharacters
            case .favourite:
                favouriteCharacters
            }
            bottomBar.opacity(0)
        }
        .transition(.move(edge: .trailing))
    }
    
    private var allCharacters: some View {
        ScrollView {
            VStack {
                DividerHeader(title: "Base")
                
                RolesGrid(
                    roles: $viewModel.classicCharacters,
                    selectedRoles: viewModel.selectedCharacters,
                    playersCount: viewModel.playersForGame.count
                )
                
                DividerHeader(title: "More")
                
                RolesGrid(
                    roles: $viewModel.moreCharacters,
                    selectedRoles: viewModel.selectedCharacters,
                    playersCount: viewModel.playersForGame.count
                )
            }
            .padding(.bottom, 10)
        }
    }
    
    private var favouriteCharacters: some View {
        ScrollView {
            VStack {
                DividerHeader(title: "Favourite")
                
                RolesGrid(
                    roles: $viewModel.favouriteCharacters,
                    selectedRoles: viewModel.selectedCharacters,
                    playersCount: viewModel.playersForGame.count
                )
            }
            .padding(.bottom, 10)
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

struct RolesGrid: View {
    @Binding var roles: [Role]
    let selectedRoles: [Role]
    let playersCount: Int
    private let columns: [GridItem] = [
        GridItem(.adaptive(minimum: UIScreen.main.bounds.width / 3, maximum: 700))
    ]
    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(0..<roles.count, id: \.self) { characterIndex in
                VStack {
                    GameRoleCard(
                        character: $roles[characterIndex],
                        isSelected: isSelectedCharacter(roles[characterIndex]),
                        rangeLimit: freePlaces(for: roles[characterIndex])
                    )
                    .padding(.horizontal, 5)
                    .padding(.top, 5)
                }
            }
            .padding()
        }
    }
    func isSelectedCharacter(_ character: Role) -> Bool {
        selectedRoles.contains(where: { $0.name == character.name })
    }
    func freePlaces(for character: Role) -> Int {
        let character = selectedRoles.first(where: { $0.name == character.name})
        return playersCount - selectedRoles.count + (character?.selectedCount ?? 0)
    }
}
