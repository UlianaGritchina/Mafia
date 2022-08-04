//
//  RolesListView.swift
//  Mafia
//
//  Created by Ульяна Гритчина on 24.07.2022.
//

import SwiftUI

struct RolesListView: View {
    let results: [Result]
    var body: some View {
        List {
            ForEach(results, id: \.self) { result in
                HStack {
                    Text(result.playerName)
                        .font(.system(size: UIScreen.main.bounds.height / 45))
                    Spacer()
                    Text(result.role)
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
        RolesListView(results: [Result(playerName: "name", role: "role")])
    }
}
