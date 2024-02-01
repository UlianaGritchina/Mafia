//
//  CharacterCard.swift
//  Mafia
//
//  Created by Uliana Gritchina on 01.02.2024.
//

import SwiftUI

struct CharactersList: View {
    let characters = ["Mafia", "Sheriff", "Doctor", "Civilian", "Maniac", "Mistress", "Don", "Detective", "GameHost", "Agent", "GodFather", "Ninja", "Advocate", "Patrol", "Thief", "Yakuza", "Werewolf"]
    let columns: [GridItem] = [
        GridItem(.adaptive(minimum: UIScreen.main.bounds.width / 3, maximum: 700))
    ]
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: columns) {
                    ForEach(characters, id: \.self) { character in
                        CharacterCard(characterName: character)
                    }
                    .padding()
                }
            }
            .background(Color("background"))
            .navigationTitle("Characters")
        }
    }
}

#Preview {
    CharactersList()
        .preferredColorScheme(.dark)
}

struct CharacterCard: View {
    let characterName: String
    var body: some View {
        VStack {
            Image(characterName)
                .resizable()
                .frame(
                    width: UIScreen.main.bounds.width / 2.5,
                    height: UIScreen.main.bounds.width / 2.5
                )
            Text(characterName)
                .font(.system(size: 18, weight: .bold, design: .serif))
        }
        .padding(.horizontal)
        .padding(.bottom, 5)
        .frame(width: UIScreen.main.bounds.width / 2.5)
        .background(.ultraThinMaterial)
        .cornerRadius(10)
    }
}

//Character(name: "Мститель", count: 0),


//Character(name: "Ищейка", count: 0),
//Character(name: "Капитан", count: 0),
//Character(name: "Бессмертный", count: 0),
//Character(name: "Тюремщик", count: 0),


