import SwiftUI

struct MainView: View {
    @StateObject var vm = MainViewViewModel()
    private let height = UIScreen.main.bounds.height
    private let width = UIScreen.main.bounds.width
    private let transition: AnyTransition = .asymmetric(
        insertion: .move(edge: .trailing),
        removal: .move(edge: .leading)
    )
    private let transition2: AnyTransition = .asymmetric(
        insertion: .move(edge: .leading),
        removal: .move(edge: .trailing)
    )
    var body: some View {
        NavigationView {
            ZStack {
                switch vm.section {
                case .players: PlayersView(vm: vm).transition(transition2)
                case .characters: CharactersView(vm: vm).transition(transition)
                }
            }
            
            .animation(.spring(), value: vm.section)
            .navigationTitle("Мафия")
            
            .fullScreenCover(isPresented: $vm.isStartView) {
                GameView(results: vm.results)
            }
            
            .sheet(isPresented: $vm.isShowingSupportView) { SupportView() }
            
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    playersCounter
                }
            }
            
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) { supportButton
                }
            }
            
            .alert(isPresented: $vm.isShowingAlert) { getNoPlayersAlert() }
            
        }
        .preferredColorScheme(.dark)
    }
    
    private func getNoPlayersAlert() -> Alert {
        Alert(title: Text("Нет игроков"))
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}


// MARK: COMPONENTS

extension MainView {
    
    private var playersCounter: some View {
        Text("\(vm.totalCharacters)/\(vm.playersForGame.count)")
            .bold()
            .font(.system(size: vm.canGameStart() ? height / 40 : height / 50))
            .opacity(vm.section == .characters ? 1 : 0)
            .foregroundColor(vm.canGameStart() ? . green : .white)
            .animation(.default, value: vm.section)
    }
    
    private var supportButton: some View {
        VStack {
            Button(action: vm.showSupportView) {
                Image(systemName: "giftcard.fill")
                    .font(.system(size: height / 45))
            }
        }
    }
    
}






