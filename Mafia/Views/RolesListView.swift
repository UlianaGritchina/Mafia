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
        .preferredColorScheme(.dark)
    }
}

struct RolesListView_Previews: PreviewProvider {
    static var previews: some View {
        RolesListView(player: [Player(name: "name", role: "role")])
    }
}

