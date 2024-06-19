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
    
    @EnvironmentObject private var appearanceManager: AppearanceManager
    
    private let columns: [GridItem] = [
        GridItem(.adaptive(minimum: UIScreen.main.bounds.width / 3, maximum: 700))
    ]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            header
            charactersSetPicker
            allCharacters
        }
        .background(
            BackgroundImage()
                .environmentObject(appearanceManager)
        )
        .navigationTitle("Characters")
        .onChange(of: viewModel.selectedSet) { _ in
            viewModel.updateCharacters()
        }
        .overlay {
            VStack {
                if let character = viewModel.selectedCharacter {
                    RoleDetailView(role: character) {
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
                    ForEach(RolesSet.allCases, id: \.self) { set in
                        Text(set.title.localised).tag(set)
                    }
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
    
    private var closeButton: some View {
        Button(action: { presentationMode.wrappedValue.dismiss() }) {
            Image(systemName: "xmark")
                .font(.title2)
        }
    }
}
