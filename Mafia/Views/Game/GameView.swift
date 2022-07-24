//
//  GameView.swift
//  Mafia
//
//  Created by Ульяна Гритчина on 23.07.2022.
//

import SwiftUI

class GameViewViewModel: ObservableObject {
    let columns: [GridItem] = [
        GridItem(.adaptive(minimum: UIScreen.main.bounds.width / 3, maximum: 700))
    ]
    
}

struct GameView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var vm = GameViewViewModel()
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                RoleCardView(name: "name", role: "role")
                Spacer()
                CustomButton(title: "Следующий",
                             color: .blue,
                             action: {},
                             width: UIScreen.main.bounds.width - 80)
            }
            .navigationTitle("Игра")
            .preferredColorScheme(.dark)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {}) {
                        Image(systemName: "list.dash")
                    }
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button("Завершить") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
