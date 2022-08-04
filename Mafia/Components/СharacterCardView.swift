//
//  CharacterCardView.swift
//  Mafia
//
//  Created by Ульяна Гритчина on 23.07.2022.
//

import SwiftUI

struct CharacterCardView: View {
    @Binding var character: Character
    @Binding var totalCount: Int
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: UIScreen.main.bounds.width / 2.4,
                       height: UIScreen.main.bounds.height / 5)
                .foregroundColor(.black)
                .shadow(color: character.count != 0
                        ? .red.opacity(0.8)
                        : .white.opacity(0.4),
                        radius: 5, x: 0, y: 0)
                .overlay(characterContent)
                .onTapGesture { addDon() }
        }
    }
    
    func addDon() {
        if character.name == "Дон" {
            if character.count == 0 {
                character.count = 1
                totalCount += 1
            } else {
                totalCount -= 1
                character.count = 0
            }
        }
    }
    
}

struct CharacterCardView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterCardView(
            character: .constant(Character(name: "name", count: 1)),
            totalCount: .constant(0)
        )
    }
}

extension CharacterCardView {
    
    var characterContent: some View {
        VStack {
            Text(character.name)
                .foregroundColor(.white)
                .bold()
                .font(.system(size: UIScreen.main.bounds.height / 40))
            
            if character.name != "Дон" {
                Spacer()
                HStack {
                    CountButtonView(sign: "-", action: {
                        if character.count != 0 {
                            character.count -= 1
                            totalCount -= 1
                            HapticManager.instance.impact(style: .light)
                        }
                    })
                    Spacer()
                    Text("\(character.count)")
                        .foregroundColor(.white)
                        .bold()
                        .font(.system(size: UIScreen.main.bounds.height / 40))
                    Spacer()
                    CountButtonView(sign: "+", action: {
                        character.count += 1
                        totalCount += 1
                        HapticManager.instance.impact(style: .light)
                    })
                }
            }
        }
        .padding()
    }
    
}

