import SwiftUI

struct PlayersView: View {
    @EnvironmentObject var vm: MainViewViewModel
    var body: some View {
        ZStack {
            Image("mrRobot2")
                .resizable()
                .ignoresSafeArea()
                .blur(radius: 15)
                .opacity(0.4)
            playersList
                .overlay (
                    SubTitleView(text: "игроки"), alignment: .top
                )
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
        ScrollView(showsIndicators: false) {
            Rectangle()
                .frame(height: UIScreen.main.bounds.height / 10)
                .opacity(0)
            ForEach(0..<30) { index in
               
            }
            Rectangle()
                .frame(height: UIScreen.main.bounds.height / 15)
                .opacity(0)
        }
        .padding()
    }
    
    private var playersTabBar: some View {
        VStack {
            Spacer()
            BottomBarView()
                .overlay(
                    CustomButton(title: "Продолжить",
                                 color: .blue.opacity(0.8),
                                 action: {vm.next()},
                                 width: UIScreen.main.bounds.width - 80)
                    .padding(.bottom)
                )
        }
        .ignoresSafeArea()
    }
    
}
