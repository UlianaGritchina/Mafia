//
//  СharacterCardView.swift
//  Mafia
//
//  Created by Ульяна Гритчина on 23.07.2022.
//

import SwiftUI

struct CharacterCardView: View {
    let name: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: UIScreen.main.bounds.width / 2.4,
                       height: UIScreen.main.bounds.height / 5)
                .foregroundColor(.black)
                .shadow(color: .white.opacity(0.5), radius: 5, x: 0, y: 0)
                .overlay(characterContent)
        }
    }
}

struct CharacterCardView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterCardView(name: "name")
    }
}

extension CharacterCardView {
    
    var characterContent: some View {
        VStack {
            Text(name)
                .foregroundColor(.white)
                .bold()
                .font(.system(size: UIScreen.main.bounds.height / 40))
            
            if name != "Дон" {
                Spacer()
                HStack {
                    CountButtonView(sign: "-", action: {})
                    Spacer()
                    Text("1")
                        .foregroundColor(.white)
                        .bold()
                        .font(.system(size: UIScreen.main.bounds.height / 40))
                    Spacer()
                    CountButtonView(sign: "+", action: {})
                }
            }
        }
        .padding()
    }
    
}

