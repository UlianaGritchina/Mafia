import SwiftUI

struct MainView: View {
    @StateObject var vm = MainViewViewModel()
    private let height = UIScreen.main.bounds.height
    private let width = UIScreen.main.bounds.width
    var body: some View {
        NavigationView {
            ZStack {
                PlayersView(vm: vm).offset(x: vm.isPlayersView ? 0 : -width)
                CharactersView(vm: vm) .offset(x: !vm.isPlayersView ? 0 : width)
            }
            .navigationTitle("Мафия")
            .animation(.default, value: vm.isPlayersView)
            .onChange(of: vm.game) { _ in vm.restCharacters() }
            
            .fullScreenCover(isPresented: $vm.isStartView) {
                GameView(results: vm.results)
            }
            
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    playersCounter
                }
            }
            
            .alert("Нет игроков", isPresented: $vm.isShowingAlert) {
                Button("OK", role: .cancel) { }
            }
            
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

extension MainView {
    
    var playersCounter: some View {
        Text("\(vm.totalCharacters)/\(vm.playersForGame.count)")
            .bold()
            .font(.system(size: vm.canGameStart() ? height / 40 : height / 50))
            .opacity(vm.isPlayersView ? 0 : 1)
            .foregroundColor(vm.canGameStart() ? . green : .white)
    }
    
}






