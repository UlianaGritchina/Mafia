//
//  CharacterDetailView.swift
//  Mafia
//
//  Created by Uliana Gritchina on 03.02.2024.
//

import SwiftUI

struct CharacterDetailView: View {
    @StateObject private var viewModel: ViewModel
    let closeAction: () -> ()
    
    init(character: ChinchillaCharacter, closeAction: @escaping () -> Void) {
        self.closeAction = closeAction
        let vm = ViewModel(character: character)
        _viewModel = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        ZStack {
            VStack {
                closeButton
                CharacterCard(character: viewModel.character, cardSize: .detail)
                Text("description")
                Spacer()
                actionButtons
            }
            .padding()
        }
        .background(background)
        .onTapGesture { closeAction() }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    CharacterDetailView(
        character: ChinchillaCharacter(
            name: "Mafia",
            imageName: "Mafia",
            isLock: false
        ),
        closeAction: { }
    )
}

extension CharacterDetailView {
    
    private var background: some View {
        Rectangle()
            .opacity(0)
            .background(.ultraThinMaterial)
            .ignoresSafeArea()
    }
    
    private var closeButton: some View {
        Button(action: closeAction) {
            Image(systemName: "xmark")
                .padding(10)
                .background(.ultraThinMaterial)
                .clipShape(.circle)
                .shadow(radius: 10)
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
    
    private var actionButtons: some View {
        HStack() {
            Spacer()
            addToFavoriteButton
            Spacer()
            if viewModel.character.isLock {
                unlockButton
                Spacer()
            }
        }
    }
    
    private var addToFavoriteButton: some View {
        Button(action: {  viewModel.addToFavorite() }) {
            Image(systemName: viewModel.favoriteButtonImageName)
                .font(.title3)
                .frame(width: 25, height: 25)
                .padding()
                .background(.ultraThinMaterial)
                .clipShape(.circle)
                .shadow(radius: 10)
        }
    }
    
    private var unlockButton: some View {
        Button(action: closeAction) {
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
    }
    
}
