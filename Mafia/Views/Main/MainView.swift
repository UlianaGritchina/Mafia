import SwiftUI

struct MainView: View {
    @StateObject var vm = MainViewViewModel()
    private let height = UIScreen.main.bounds.height
    private let width = UIScreen.main.bounds.width
    var body: some View {
        NavigationView {
            ZStack {
                PlayersView(vm: vm).offset(x: vm.isPlayersView ? 0 : -width)
                CharactersView(vm: vm).offset(x: !vm.isPlayersView ? 0 : width)
            }
            .navigationTitle("Мафия")
            .animation(.default, value: vm.isPlayersView)
            
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
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    infoButton
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
        MainView().preferredColorScheme(.dark)
    }
}

extension MainView {
    
    var playersCounter: some View {
        Text("\(vm.totalCharacters)/\(vm.playersForGame.count)")
            .bold()
            .font(.system(size: vm.canGameStart() ? height / 40 : height / 50))
            .opacity(vm.isPlayersView ? 0 : 1)
            .foregroundColor(vm.canGameStart() ? . green : .white)
            .animation(.default, value: vm.isPlayersView)
    }
    
    var infoButton: some View {
        VStack {
            Button(action: vm.showSupportView) {
                Image(systemName: "giftcard.fill")
                    .font(.system(size: height / 45))
            }
        }
    }
    
}






