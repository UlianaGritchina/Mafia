import SwiftUI

struct MainView: View {
    @StateObject var vm = MainViewViewModel()
    var body: some View {
        NavigationView {
            ZStack {
                playersView
                    .offset(x: vm.isPlayersView
                            ? 0
                            : -UIScreen.main.bounds.width)
                
                rolesView
                    .offset(x: !vm.isPlayersView
                            ? 0
                            : UIScreen.main.bounds.width)
                
            }
            .fullScreenCover(isPresented: $vm.isStartView, content: {
                GameView()
            })
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    playersCounter
                }
            }
            .animation(.default, value: vm.isPlayersView)
            .navigationTitle("Мафия")
        }
        .preferredColorScheme(.dark)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .preferredColorScheme(.light)
    }
}

extension MainView {
    
    //MARK: - PlayersView
    
    var playersView: some View {
        ZStack {
            VStack {
                PodTitleView(text: "Игроки")
                playersList
            }
            
            playersTabBar
        }
    }
    
    var playersList: some View {
        List {
            ForEach(0..<30) { index in
                TextField("Игрок \(index+1)", text: $vm.players[index])
                    .font(.system(size: UIScreen.main.bounds.height / 40))
            }
            Text("").padding()
        }
        .listStyle(.inset)
    }
    
    var playersTabBar: some View {
        VStack {
            Spacer()
            BackRectView()
                .overlay(
                    CustomButton(title: "Продолжить",
                                 color: .blue,
                                 action: {vm.isPlayersView.toggle()},
                                 width: UIScreen.main.bounds.width - 80)
                        .padding(.bottom)
                )
        }
        .ignoresSafeArea()
    }
    
    //MARK: - RolesView
    
    var rolesView: some View {
        ZStack {
            VStack {
                PodTitleView(text: "Персонажи")
                gamePicker
                rolesList
            }
            rolesTabBar
        }
    }
    
    var gamePicker: some View {
        Picker(selection: $vm.game, label: Text("Picker")) {
            Text("Классика").tag(GameType.base)
            Text("Больше").tag(GameType.more)
        }
        .pickerStyle(.segmented)
    }
    
    
    var rolesList: some View {
        ScrollView {
            LazyVGrid(columns: vm.columns) {
                ForEach(vm.game == .base
                        ? vm.baseCharacters
                        : vm.characters, id: \.self) { character in
                    CharacterCardView(name: character)
                        .padding()
                }
            }
        }
        .padding(.bottom, UIScreen.main.bounds.height / 18)
    }
    
    var rolesTabBar: some View {
        VStack {
            Spacer()
            BackRectView()
                .overlay(HStack {
                    CustomButton(title: "Назад",
                                 color: .blue,
                                 action: {vm.isPlayersView.toggle()})
                    Spacer()
                    CustomButton(title: "Начать",
                                 color: .red,
                                 action: {vm.isStartView.toggle()})
                }
                            .padding()
                            .padding(.bottom)
                )
        }
        .ignoresSafeArea()
    }
    
    var playersCounter: some View {
        Text("0/\(vm.players.count)")
            .bold()
            .font(.system(size: UIScreen.main.bounds.height / 50))
            .opacity(vm.isPlayersView ? 0 : 1)
    }
    
}






