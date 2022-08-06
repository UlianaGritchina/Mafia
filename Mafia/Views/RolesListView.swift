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
                HStack {
                    Text(player.name)
                        .font(.system(size: UIScreen.main.bounds.height / 45))
                    Spacer()
                    Text(player.role)
                        .bold()
                        .font(.system(size: UIScreen.main.bounds.height / 45))
                        .padding(.horizontal)
                }
            }
        }
    }
}

struct RolesListView_Previews: PreviewProvider {
    static var previews: some View {
        RolesListView(player: [Player(name: "name", role: "role")])
    }
}
