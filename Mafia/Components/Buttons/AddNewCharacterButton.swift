//
//  AddCharacterView.swift
//  Mafia
//
//  Created by Ульяна Гритчина on 06.08.2022.
//

import SwiftUI

struct AddNewCharacterButton: View {
    @State private var showAddCharacterView = false
    var body: some View {
        VStack {
            Button(action: {showAddCharacterView.toggle()}) {
                buttonContent
            }
        }
        .sheet(isPresented: $showAddCharacterView) {
            AddNewCharacterView()
        }
    }
}

struct AddCharacterView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewCharacterButton()
    }
}

extension AddNewCharacterButton {
    
    var buttonContent: some View {
        RoundedRectangle(cornerRadius: 20)
            .stroke(style: .init(lineWidth: 1, lineCap: .square, lineJoin: .round, miterLimit: 5, dash: [10, 12], dashPhase: 5))
            .frame(width: UIScreen.main.bounds.width / 2.4,
                   height: UIScreen.main.bounds.height / 5)
            .preferredColorScheme(.dark)
            .overlay(
                Text("Добавить")
                    .bold()
                    .font(.system(size: UIScreen.main.bounds.height / 40))
            )
            .opacity(0.7)
    }
    
}
