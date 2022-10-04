import SwiftUI

struct MainView: View {
    @StateObject var vm = MainViewViewModel()
    private let height = UIScreen.main.bounds.height
    private let width = UIScreen.main.bounds.width
    var body: some View {
        NavigationView {
            ZStack {
                
                playersSection.offset(x: vm.section == .players ? 0 : -width)
                CharactersView().offset(x: vm.section == .characters ? 0 : width)
                
            }
            .navigationTitle(vm.isShowingEgg ? "" : "Мафия")
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarItems(leading: navigationBarLeading,
                                trailing: navigationBarTrailing)
            .preferredColorScheme(.dark)
            .environmentObject(vm)
            .animation(.spring(), value: vm.section)
            .alert(isPresented: $vm.isShowingAlert) { getNoPlayersAlert() }
            
            .fullScreenCover(isPresented: $vm.isStartView) {
                GameView(results: vm.results)
            }
            
            .sheet(isPresented: $vm.isShowingSupportView) { SupportView() }
            
            .fullScreenCover(isPresented: $vm.isShowingFinalEggsView, content: {
                FinalEasterEggView()
            })
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) { doneButtonForToolBar }
            }
        }
    }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}


// MARK: COMPONENTS

extension MainView {
    
    private var doneButtonForToolBar: some View {
        Button("Готово") { UIApplication.shared.endEditing() }
            .padding(.leading, width - 80)
    }
    
    private var playersSection: some View {
        ZStack {
            EasterEggView().opacity(vm.isShowingEgg ? 1 : 0)
            PlayersView().offset(y: vm.isShowingEgg ? -height : 0)
        }
        .animation(.easeInOut, value: vm.isShowingEgg)
    }
    
    private var playersCounter: some View {
        Text("\(vm.totalCharacters)/\(vm.playersForGame.count)")
            .bold()
            .font(.system(size: vm.canGameStart() ? height / 40 : height / 50))
            .opacity(vm.section == .characters ? 1 : 0)
            .foregroundColor(vm.canGameStart() ? . green : .white)
            .animation(.default, value: vm.section)
    }
    
    private var navigationBarLeading: some View {
        VStack {
            if vm.isShowingEgg {
                backButton
            } else {
                supportButton
            }
        }
    }
    
    private var navigationBarTrailing: some View {
        VStack {
            if vm.isShowingEgg {
                enterButton
            } else {
                playersCounter
            }
        }
    }
    
    private var supportButton: some View {
        VStack {
            Button(action: vm.showSupportView) {
                Image(systemName: "giftcard.fill")
                    .font(.system(size: height / 45))
                    .opacity(vm.isShowingEgg ? 0 : 1)
                    .animation(.default, value: vm.isShowingEgg)
            }
        }
    }
    
    private var backButton: some View {
        Button(action: {vm.isShowingEgg.toggle()}) {
            Image(systemName: "arrow.down.to.line.compact")
                .font(.system(size: height / 45))
                .animation(.default, value: vm.isShowingEgg)
                .foregroundColor(.white)
                .frame(width: 50, height: 40)
                .background(Color.black)
                .cornerRadius(10)
        }
    }
    
    private var enterButton: some View {
        Button(action: {vm.showFinalEggsView()}) {
            Text("Войти")
                .bold()
                .foregroundColor(.white)
                .frame(width: 100, height: 40)
                .background(Color.black)
                .cornerRadius(10)
        }
        
    }
    
}


// MARK:  FUNCTIONS

extension MainView {
    private func getNoPlayersAlert() -> Alert {
        Alert(title: Text("Нет игроков"))
    }
}

