//
//  AllPlayersView.swift
//  Mafia
//
//  Created by Ульяна Гритчина on 15.06.2024.
//

import SwiftUI

struct AllPlayersView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject private var appearanceManager: AppearanceManager
    
    let players: [String]
    let roles: [Role]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                closeButton
                playersList
            }
            .padding()
        }
        .background(BackgroundImage().environmentObject(appearanceManager))
    }
}

#Preview {
    AllPlayersView(players: [], roles: [])
}

extension AllPlayersView {
    
    private var closeButton: some View {
        Button(action: { presentationMode.wrappedValue.dismiss() }, label: {
            Image(systemName: "xmark")
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .trailing)
        })
    }
    
    private var playersList: some View {
        ForEach(0..<players.count, id: \.self) { index in
            Text(players[index] + " - " + roles[index].name)
                .font(.system(size: 20, weight: .bold, design: .serif))
            Divider()
        }
    }
}
