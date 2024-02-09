//
//  CharacterCard.swift
//  Mafia
//
//  Created by Uliana Gritchina on 01.02.2024.
//

import SwiftUI

struct CharactersList: View {
    @StateObject private var viewModel = ViewModel()
    @Environment(\.presentationMode) var presentationMode
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
            .background(BackgroundImage())
            .navigationTitle("Characters")
            .navigationBarItems(trailing: closeButton)
            .overlay(alignment: .bottom) {  picker }
        }
        .overlay {
            VStack {
                if let character = viewModel.selectedCharacter {
                    CharacterDetailView(character: character) {
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
                    .buttonStyle(ScaleButtonStyle())
                }
                .padding()
            }
            
            DividerHeader(title: "More")
            
            LazyVGrid(columns: columns) {
                ForEach(viewModel.moreCharacters) { character in
                    Button(action: { viewModel.showCharacterDetail(character) }) {
                        CharacterCard(character: character)
                    }
                    .buttonStyle(ScaleButtonStyle())
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
    
    private var closeButton: some View {
        Button(action: {presentationMode.wrappedValue.dismiss()}) {
            Image(systemName: "xmark")
        }
    }
    
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
