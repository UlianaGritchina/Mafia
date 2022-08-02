//
//  GameView.swift
//  Mafia
//
//  Created by Ульяна Гритчина on 23.07.2022.
//

import SwiftUI

class GameViewViewModel: ObservableObject {
    
}

struct GameView: View {
    @Environment(\.presentationMode) var presentationMode
    let results: [Result]
    @State private var index = 0
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                ScrollView(showsIndicators: false) {
                    ForEach(results, id: \.self) { result in
                        RoleCardView(name: result.playerName,
                                     role: result.role)
                    }
                    .frame(width: UIScreen.main.bounds.width)
                }
                .frame(width: UIScreen.main.bounds.width)
            }
            .navigationTitle("Игра")
            .preferredColorScheme(.dark)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    NavigationLink(destination: RolesListView(results: results)) {
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
        GameView(results: [Result(playerName: "name", role: "character")])
    }
}
