//
//  Players3View.swift
//  Mafia
//
//  Created by Uliana Gritchina on 03.02.2024.
//

import SwiftUI

struct PlayersList: View {
    @Binding var players: [String]
    var body: some View {
            ScrollView {
                LazyVStack(spacing: 20) {
                    ForEach(0..<30) { index in
                        TextField("Player \(index + 1)", text: $players[index])
                            .font(.title2)
                            .padding()
                            .background(.ultraThinMaterial)
                            .cornerRadius(15)
                    }
                    .padding(.horizontal)
                }
                .padding(.top)
                .padding(.bottom, 70)
            }
            .navigationTitle("Players")
        .background(Color("background"))
    }
}

#Preview {
    PlayersList(players: .constant([]))
}
