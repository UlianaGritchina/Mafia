import SwiftUI

struct PlayersView: View {
    @EnvironmentObject var vm: MainViewViewModel
    var body: some View {
        ZStack {
            VStack {
                SubTitleView(text: "Игроки")
                playersList
            }
            playersTabBar
        }
    }
}

struct PlayersView_Previews: PreviewProvider {
    static var previews: some View {
        PlayersView()
    }
}


// MARK: COMPONENTS

extension PlayersView {
    
   private var playersList: some View {
        List {
            ForEach(0..<30) { index in
                TextField("Игрок \(index+1)", text: $vm.players[index])
                    .font(.system(size: UIScreen.main.bounds.height / 40))
            }
            Text("").padding()
        }
        .listStyle(.inset)
    }
    
   private var playersTabBar: some View {
        VStack {
            Spacer()
            BottomBarView()
                .overlay(
                    CustomButton(title: "Продолжить",
                                 color: .blue,
                                 action: {vm.next()},
                                 width: UIScreen.main.bounds.width - 80)
                        .padding(.bottom)
                )
        }
        .ignoresSafeArea()
    }
    
}
