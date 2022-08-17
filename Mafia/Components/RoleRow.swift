import SwiftUI

struct RoleRow: View {
    let player: Player
    var body: some View {
        VStack(alignment: .leading) {
            Text(player.name).bold()
            Text(player.role)
        }
        .font(.system(size: UIScreen.main.bounds.height / 40))
    }
}

struct RoleRow_Previews: PreviewProvider {
    static var previews: some View {
        RoleRow(player: Player(name: "Ульана", role: "Мафия"))
    }
}
