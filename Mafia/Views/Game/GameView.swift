import SwiftUI

struct GameView: View {
    @Environment(\.presentationMode) var presentationMode
    let results: [Player]
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
        .preferredColorScheme(.dark)
    }
    
    func getPercentage(geo: GeometryProxy) -> Double {
        let maxDistance = UIScreen.main.bounds.height / 2
        let currentX = geo.frame(in: .global).midY
        return Double(1 - (currentX / maxDistance))
    }
    
    
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(results: [Player(name: "name1", role: "character"),
                           Player(name: "name2", role: "character"),
                           Player(name: "name3", role: "character")])
    }
}


// MARK: COMPONENTS

extension GameView {
    
    private var rolesScrollView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            Text("").padding(UIScreen.main.bounds.height / 25)
            resultsView.padding()
            Text("").padding(UIScreen.main.bounds.height / 12)
        }
    }
    
    private var resultsView: some View {
        ForEach(results, id: \.self) { player in
            GeometryReader { geometry in
                RoleCardView(player: player)
                    .rotation3DEffect(
                        Angle(degrees: getPercentage(geo: geometry) * 40),
                        axis: (x: 0.2, y: 0.0, z: 0.0))
            }
            .frame(width: UIScreen.main.bounds.width / 1.5,
                   height: UIScreen.main.bounds.height / 2)
        }
        .frame(width: UIScreen.main.bounds.width)
    }
    
    private var rolesListLink: some View {
        NavigationLink(destination: RolesListView(player: results)) {
            Image(systemName: "list.dash")
        }
    }
    
   private var endGameButton: some View {
        Button("Завершить") {
            presentationMode.wrappedValue.dismiss()
        }
    }
    
}
