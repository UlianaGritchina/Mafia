//
//  AllPlayersView.swift
//  Mafia
//
//  Created by Ульяна Гритчина on 15.06.2024.
//

import SwiftUI

struct AllPlayersView: View {
    @Environment(\.presentationMode) var presentationMode
    let players: [String]
    let roles: [Role]
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                Button(action: { presentationMode.wrappedValue.dismiss() }, label: {
                    Image(systemName: "xmark")
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                })
                ForEach(0..<players.count, id: \.self) { index in
                    Text(players[index] + " - " + roles[index].name)
                        .font(.system(size: 20, weight: .bold, design: .serif))
                    Divider()
                }
            }
            .padding()
        }
        .background(BackgroundImage())
    }
}

#Preview {
    AllPlayersView(players: [], roles: [])
}
