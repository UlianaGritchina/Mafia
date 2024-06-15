//
//  AllPlayersView.swift
//  Mafia
//
//  Created by Ульяна Гритчина on 15.06.2024.
//

import SwiftUI

struct AllPlayersView: View {
    let players: [String]
    let roles: [Role]
    var body: some View {
        ScrollView {
            ForEach(0..<players.count, id: \.self) { index in
                Text(players[index] + " - " + roles[index].name)
            }
        }
    }
}

#Preview {
    AllPlayersView(players: [], roles: [])
}
