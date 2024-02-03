//
//  CharacterCard.swift
//  Mafia
//
//  Created by Uliana Gritchina on 02.02.2024.
//

import SwiftUI

enum CharacterCardSize {
    case regular
    case detail
}

struct CharacterCard: View {
    let character: ChinchillaCharacter
    var cardSize: CharacterCardSize = .regular
    
    init(character: ChinchillaCharacter, cardSize: CharacterCardSize = .regular) {
        self.character = character
        self.cardSize = cardSize
    }
    
    var body: some View {
        VStack {
            Image(character.imageName)
                .resizable()
                .frame(width: getCardSize(), height: getCardSize() )
                .overlay {
                    if character.isLock {
                        ZStack {
                            Rectangle()
                                .foregroundColor(.black)
                                .opacity(0.8)
                            Image(systemName: "lock")
                                .font(.system(size: 30))
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            Text(character.name)
                .font(.system(size: 18, weight: .bold, design: .serif))
        }
        .padding(.horizontal)
        .padding(.bottom, 5)
        .frame(width: getCardSize())
        .background(.ultraThinMaterial)
        .cornerRadius(10)
    }
    
    private func getCardSize() -> CGFloat {
        switch cardSize {
        case .regular:
            return  UIScreen.main.bounds.width / 2.5
        case .detail:
            return UIScreen.main.bounds.height / 3
        }
    }
}

#Preview {
    CharacterCard(
        character: ChinchillaCharacter(
            name: "Mafia",
            imageName: "Mafia",
            isLock: false
        )
    )
}
