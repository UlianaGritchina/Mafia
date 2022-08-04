//
//  GameView.swift
//  Mafia
//
//  Created by Ульяна Гритчина on 23.07.2022.
//

import SwiftUI

struct GameView: View {
    @Environment(\.presentationMode) var presentationMode
    let results: [Result]
    var body: some View {
        NavigationView {
            rolesScrollView
                .navigationTitle("Игра")
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        rolesListLink
                    }
                }
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        endGameButton
                    }
                }
        }
    }
    
    func getPercentage(geo: GeometryProxy) -> Double {
        let maxDistance = UIScreen.main.bounds.height / 2
        let currentX = geo.frame(in: .global).midY
        return Double(1 - (currentX / maxDistance))
    }
    
    
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(results: [Result(playerName: "name1", role: "character"),
                           Result(playerName: "name2", role: "character"),
                           Result(playerName: "name3", role: "character")])
    }
}

extension GameView {
    
    var rolesScrollView: some View {
        ScrollView(.vertical, showsIndicators: false, content: {
            Text("").padding(40)
            VStack(spacing: 100) {
                ForEach(results, id: \.self) { result in
                    GeometryReader { geometry in
                        RoleCardView(name: result.playerName,
                                     role: result.role)
                            .rotation3DEffect(
                                Angle(degrees: getPercentage(geo: geometry) * 40),
                                axis: (x: 0.2, y: 0.0, z: 0.0))
                    }
                    .frame(width: UIScreen.main.bounds.width / 1.5,
                           height: UIScreen.main.bounds.height / 2.5)
                }
                .frame(width: UIScreen.main.bounds.width)
            }.padding()
            Text("").padding(100)
        })
    }
    
    var rolesListLink: some View {
        NavigationLink(destination: RolesListView(results: results)) {
            Image(systemName: "list.dash")
        }
    }
    
    var endGameButton: some View {
        Button("Завершить") {
            presentationMode.wrappedValue.dismiss()
        }
    }
    
}
