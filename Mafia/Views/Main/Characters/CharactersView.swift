import SwiftUI

struct CharactersView: View {
    @ObservedObject var vm: MainViewViewModel
    var body: some View {
        ZStack {
            VStack {
                SubTitleView(text: "Персонажи")
                gamePicker.padding(.horizontal)
                rolesList
            }
            rolesTabBar
        }
        .onChange(of: vm.game) { _ in vm.restCharacters() }
    }
}

struct CharactersView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersView(vm: MainViewViewModel())
            .preferredColorScheme(.dark)
    }
}

extension CharactersView {
    
    var gamePicker: some View {
        Picker(selection: $vm.game, label: Text("Picker")) {
            Text("Классика").tag(GameType.base)
            Text("Избранные").tag(GameType.favorites)
            Text("Больше").tag(GameType.more)
        }
        .pickerStyle(.segmented)
    }
    
    var rolesList: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: vm.columns) {
                switch vm.game {
                case .favorites:
                    CharactersGridView(characters: $vm.favoritesCharacters,
                                       totalCharacters: $vm.totalCharacters)
                case .base:
                    CharactersGridView(characters: $vm.baseCharacters,
                                       totalCharacters: $vm.totalCharacters)
                case .more:
                    CharactersGridView(characters: $vm.moreCharacters,
                                       totalCharacters: $vm.totalCharacters)
                }
            }
        }
        .padding(.bottom, UIScreen.main.bounds.height / 18)
    }
    
    var rolesTabBar: some View {
        VStack {
            Spacer()
            BottomBarView()
                .overlay(HStack {
                    CustomButton(title: "Назад", color: .blue, action: vm.back)
                    Spacer()
                    CustomButton(title: "Начать",
                                 color: vm.canGameStart() ? .green : .gray,
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
            .font(
                .system(
                    size: vm.totalCharacters == vm.playersForGame.count
                    ?  UIScreen.main.bounds.height / 45
                    :  UIScreen.main.bounds.height / 50
                )
            )
            .opacity(vm.isPlayersView ? 0 : 1)
            .foregroundColor(vm.totalCharacters == vm.playersForGame.count
                             ? . green : .white)
    }
    
}

