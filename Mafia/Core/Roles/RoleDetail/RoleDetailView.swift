//
//  CharacterDetailView.swift
//  Mafia
//
//  Created by Uliana Gritchina on 03.02.2024.
//

import SwiftUI

struct RoleDetailView: View {
    @StateObject private var viewModel: ViewModel
    
    let closeAction: () -> ()
    
    init(role: Role, closeAction: @escaping () -> Void) {
        self.closeAction = closeAction
        let vm = ViewModel(character: role)
        _viewModel = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        ZStack {
            VStack {
                closeButton
                CharacterCard(character: viewModel.character, cardSize: .detail)
                Text(viewModel.character.description)
                    .multilineTextAlignment(.center)
                    .padding()
                Spacer()
            }
            .padding()
        }
        .background(background)
        .onTapGesture { closeAction() }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    RoleDetailView(
        role:
            Role(
                name: "Mafia",
                imageName: "Mafia"
            ),
        closeAction: { }
    )
}

extension RoleDetailView {
    
    private var background: some View {
        Rectangle()
            .foregroundColor(.black)
            .opacity(0.2)
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
}
