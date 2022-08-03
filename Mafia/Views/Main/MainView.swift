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
                GameView(results: vm.results)
            })
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    playersCounter
                }
            }
            .alert("Нет игроков", isPresented: $vm.isShowingAlert) {
                Button("OK", role: .cancel) { }
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
                                 action: {vm.next()},
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
                ForEach(0..<7) { index in
                    CharacterCardView(character: $vm.moreCharacters[index],
                                      totalCount: $vm.totalCharacters)
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
                    CustomButton(title: "Назад", color: .blue, action: vm.back)
                    Spacer()
                    CustomButton(title: "Начать",
                                 color: vm.canStart() ? .green : .gray,
                                 action: vm.start)
                }
                            .padding()
                            .padding(.bottom)
                )
        }
        .ignoresSafeArea()
    }
    
    var playersCounter: some View {
        Text("\(vm.totalCharacters)/\(vm.playersForGame.count)")
            .bold()
            .font(.system(size: vm.totalCharacters == vm.playersForGame.count
                          ?  UIScreen.main.bounds.height / 45
                          :  UIScreen.main.bounds.height / 50
                         )
            )
            .opacity(vm.isPlayersView ? 0 : 1)
            .foregroundColor(vm.totalCharacters == vm.playersForGame.count
                             ? . green
                             : .white)
    }
    
}






