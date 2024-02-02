//
//  CharacterCard.swift
//  Mafia
//
//  Created by Uliana Gritchina on 01.02.2024.
//

import SwiftUI

struct ChinchillaCharacter: Identifiable {
    let id = UUID().uuidString
    let name: String
    let imageName: String
    let isLock: Bool
}

struct CharactersList: View {
    let classicCharacters = [
        ChinchillaCharacter(name: "Mafia", imageName: "Mafia", isLock: false),
        ChinchillaCharacter(name: "Sheriff", imageName: "Sheriff", isLock: false),
        ChinchillaCharacter(name: "Doctor", imageName: "Doctor", isLock: false),
        ChinchillaCharacter(name: "Civilian", imageName: "Civilian", isLock: false),
        ChinchillaCharacter(name: "Mistress", imageName: "Mistress", isLock: false),
        ChinchillaCharacter(name: "Maniac", imageName: "Maniac", isLock: false),
        ChinchillaCharacter(name: "Game Host", imageName: "GameHost", isLock: false)
    ]
    let moreCharacters = [
        ChinchillaCharacter(name: "Don", imageName: "Don", isLock: false),
        ChinchillaCharacter(name: "Detective", imageName: "Detective", isLock: false),
        ChinchillaCharacter(name: "Werewolf", imageName: "Werewolf", isLock: false),
        ChinchillaCharacter(name: "Agent", imageName: "Agent", isLock: true),
        ChinchillaCharacter(name: "God Father", imageName: "GodFather", isLock: true),
        ChinchillaCharacter(name: "Ninja", imageName: "Ninja", isLock: true),
        ChinchillaCharacter(name: "Advocate", imageName: "Advocate", isLock: false),
        ChinchillaCharacter(name: "Patrol", imageName: "Patrol", isLock: false),
        ChinchillaCharacter(name: "Thief", imageName: "Thief", isLock: true),
        ChinchillaCharacter(name: "Yakuza", imageName: "Yakuza", isLock: false)
    ]
   
    let columns: [GridItem] = [
        GridItem(.adaptive(minimum: UIScreen.main.bounds.width / 3, maximum: 700))
    ]
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                
                Text("Base")
                    .font(.system(size: 18, weight: .bold, design: .serif))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top)
                Divider()
                    .padding(.horizontal)
                
                LazyVGrid(columns: columns) {
                    ForEach(classicCharacters) { character in
                        CharacterCard(character: character)
                    }
                    .padding()
                }
                
                Text("More")
                    .font(.system(size: 18, weight: .bold, design: .serif))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top)
                Divider()
                    .padding(.horizontal)
                
                LazyVGrid(columns: columns) {
                    ForEach(moreCharacters) { character in
                        CharacterCard(character: character)
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
    let character: ChinchillaCharacter
    var body: some View {
        VStack {
            Image(character.imageName)
                .resizable()
                .frame(
                    width: UIScreen.main.bounds.width / 2.5,
                    height: UIScreen.main.bounds.width / 2.5
                )
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
        .frame(width: UIScreen.main.bounds.width / 2.5)
        .background(.ultraThinMaterial)
        .cornerRadius(10)
    }
}



