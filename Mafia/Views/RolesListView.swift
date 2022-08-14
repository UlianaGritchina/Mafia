//
//  RolesListView.swift
//  Mafia
//
//  Created by Ульяна Гритчина on 24.07.2022.
//

import SwiftUI

struct RolesListView: View {
    let player: [Player]
    var body: some View {
        List {
            ForEach(player, id: \.self) { player in
                RoleRow(player: player)
            }
        }
        .navigationTitle("Роли")
    }
}

struct RolesListView_Previews: PreviewProvider {
    static var previews: some View {
        RolesListView(player: [Player(name: "name", role: "role")])
    }
}

