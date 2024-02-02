//
//  CharacterCard.swift
//  Mafia
//
//  Created by Uliana Gritchina on 01.02.2024.
//

import SwiftUI

struct CharactersList: View {
    @StateObject private var viewModel = ViewModel()
    private let columns: [GridItem] = [
        GridItem(.adaptive(minimum: UIScreen.main.bounds.width / 3, maximum: 700))
    ]
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                switch viewModel.selectedCharactersType {
                case .all:
                    allCharacters
                case .favourite:
                    favouriteCharacters
                }
            }
            .background(Color("background"))
            .navigationTitle("Characters")
            .overlay(alignment: .bottom) {  picker }
        }
        .overlay {
            VStack {
                if let character = viewModel.selectedCharacter {
                    ZStack {
                        Rectangle()
                            .opacity(0)
                            .background(.ultraThinMaterial)
                            .ignoresSafeArea()
                        VStack {
                            Button(action: {
                                viewModel.closeCharacterDetail()
                            }) {
                                Image(systemName: "xmark")
                                    .padding(10)
                                    .background(.ultraThinMaterial)
                                    .clipShape(.circle)
                                    .shadow(radius: 10)
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            CharacterCard(character: character, cardSize: .detail)
                            Text("")
                            Spacer()
                            
                            HStack() {
                                Spacer()
                                Button(action: {
                                    
                                }) {
                                    Image(systemName: "star")
                                        .font(.title3)
                                        .frame(width: 25, height: 25)
                                        .padding()
                                        .background(.ultraThinMaterial)
                                        .clipShape(.circle)
                                        .shadow(radius: 10)
                                }
                                Spacer()
                                
                               
                                if character.isLock {
                                    Button(action: { viewModel.closeCharacterDetail() }) {
                                        HStack {
                                            Image(systemName: "lock.open")
                                            Text("Watch Ad")
                                        }
                                        .padding(.vertical)
                                        .padding(.horizontal)
                                        .background(.ultraThinMaterial)
                                        .cornerRadius(10)
                                        .shadow(radius: 10)
                                    }
                                    Spacer()
                                }
                            }
                            
                        }
                        .padding()
                    }
                    .onTapGesture {
                        viewModel.closeCharacterDetail()
                    }
                }
            }
            .animation(.default, value: viewModel.isShowCharacterDetail)
        }
    }
}

#Preview {
    CharactersList()
        .preferredColorScheme(.dark)
}

// MARK: - UI Elements

extension CharactersList {
    
    private var allCharacters: some View {
        VStack {
            DividerHeader(title: "Base")
            
            LazyVGrid(columns: columns) {
                ForEach(viewModel.classicCharacters) { character in
                    Button(action: { viewModel.showCharacterDetail(character) }) {
                        CharacterCard(character: character)
                    }
                }
                .padding()
            }
            
            DividerHeader(title: "More")
            
            LazyVGrid(columns: columns) {
                ForEach(viewModel.moreCharacters) { character in
                    Button(action: { viewModel.showCharacterDetail(character) }) {
                        CharacterCard(character: character)
                    }
                }
                .padding()
            }
        }
        .padding(.bottom, 50)
    }
    
    private var favouriteCharacters: some View {
        VStack {
            DividerHeader(title: "Favourite")
            
            LazyVGrid(columns: columns) {
                ForEach(viewModel.favouriteCharacters) { character in
                    Button(action: { viewModel.showCharacterDetail(character) }) {
                        CharacterCard(character: character)
                    }
                }
                .padding()
            }
        }
        .padding(.bottom, 50)
    }
    
    private var picker: some View {
        Picker(selection: $viewModel.selectedCharactersType, label: Text("Picker")) {
            Text("All").tag(CharactersType.all)
            Text("Favourite").tag(CharactersType.favourite)
        }
        .pickerStyle(.segmented)
        .padding(.horizontal)
        .padding(.top, 5)
        .padding(.bottom)
        .background(.thinMaterial)
    }
    
    struct DividerHeader: View {
        let title: String
        var body: some View {
            VStack {
                Text(title)
                    .font(.system(size: 18, weight: .bold, design: .serif))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top)
                Divider()
                    .padding(.horizontal)
            }
        }
    }
}
