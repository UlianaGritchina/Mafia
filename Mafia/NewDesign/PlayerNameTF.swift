//
//  PlayerNameTF.swift
//  Mafia
//
//  Created by Ульяна Гритчина on 05.01.2023.
//

import SwiftUI

struct PlayerNameTF: View {
    @Binding var playerName: String
    let index: Int
    var body: some View {
        TextField("Игрок \(index)", text: $playerName)
            .font(.system(size: 18, weight: .medium, design: .serif))
            .frame(height: 45)
            .padding(.horizontal)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.gray.opacity(0.1))
            )
            .cornerRadius(10)
    }
}

struct PlayerNameTF_Previews: PreviewProvider {
    static var previews: some View {
        PlayerNameTF(playerName: .constant(""), index: 1)
            .preferredColorScheme(.dark)
    }
}
