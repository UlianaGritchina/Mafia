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
        ScrollView(showsIndicators: false) {
            header
            charactersSetPicker
            allCharacters
        }
        .background(BackgroundImage())
        .navigationTitle("Characters")
        .onChange(of: viewModel.selectedSet) { _ in
            viewModel.updateCharacters()
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
    
    private var header: some View {
        HStack {
            Text("Characters")
                .font(.system(size: 30, weight: .bold, design: .serif))
            Spacer()
            closeButton
        }
        .padding()
        .padding(.top)
    }
    
    private var charactersSetPicker: some View {
        VStack {
            HStack {
                Text("Style")
                    .font(.system(size: 18, weight: .bold, design: .serif))
                Spacer()
                Picker("Characters set", selection: $viewModel.selectedSet) {
                    Text("Cartoon").tag(CharacterSet.cartoon)
                    Text("Chinchillas").tag(CharacterSet.chinchillas)
                    Text("Real").tag(CharacterSet.real)
                }
            }
            Divider()
        }
        .padding(.horizontal, 16)
    }
    
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
    
    private var closeButton: some View {
        Button(action: {presentationMode.wrappedValue.dismiss()}) {
            Image(systemName: "xmark")
                .font(.title2)
        }
    }
}

struct DividerHeader: View {
    let title: String
    var body: some View {
        VStack {
            Text(title.localised)
                .font(.system(size: 18, weight: .bold, design: .serif))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top)
            Divider()
                .padding(.horizontal)
        }
    }
}

extension String {
    var localised: String {
        NSLocalizedString(self, comment: "")
    }
}
