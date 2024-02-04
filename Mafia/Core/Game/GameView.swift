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
            ZStack {
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
                VStack(spacing: 0) {
                    Spacer()
                    if viewModel.isShowRoles {
                        picker
                    }
                    startButton
                }
            }
            .navigationTitle(viewModel.navigationTitle)
            .navigationBarItems(trailing: closeButton)
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
                HStack {
                    Spacer()
                    Button(action: { viewModel.backButtonTapped() }) {
                        Text("Back")
                            .font(.system(size: 28, weight: .bold, design: .serif))
                            .padding(.bottom, 8)
                    }
                    Spacer()
                    Button(action: {  }) {
                        Text("Start")
                            .font(.system(size: 28, weight: .bold, design: .serif))
                            .padding(.bottom, 8)
                    }
                    Spacer()
                }
            } else {
                Button(action: { viewModel.nextButtonTapped() }) {
                    Text("Next")
                        .font(.system(size: 28, weight: .bold, design: .serif))
                        .padding(.bottom, 8)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 6)
        .background(.thinMaterial)
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
                            Button(action: { }) {
                                CharacterCard(character: character)
                            }
                            .buttonStyle(ScaleButtonStyle())
                            HStack {
                                Text("-")
                                    .font(.title)
                                Spacer()
                                Text("0")
                                Spacer()
                                Text("+")
                                    .font(.title)
                            }
                            .font(.headline)
                            .padding(.horizontal)
                            
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
        .background(.thinMaterial)
    }
}
