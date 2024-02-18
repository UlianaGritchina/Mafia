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
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 20) {
                ForEach(0..<30) { index in
                    TextField("Player \(index + 1)", text: $players[index])
                        .font(.title3)
                        .padding(13)
                        .background(Color.black.opacity(0.2))
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke()
                                .opacity(0.2)
                        }
                        .cornerRadius(10)
                }
                .padding(.horizontal)
            }
            .padding(.top)
            .padding(.bottom, 70)
        }
        .navigationTitle("Players")
    }
}

#Preview {
    PlayersList(players: .constant([]))
}
