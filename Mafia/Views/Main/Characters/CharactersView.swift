import SwiftUI

struct CharactersView: View {
    @EnvironmentObject var vm: MainViewViewModel
    var body: some View {
        ZStack {
            VStack {
                SubTitleView(text: "Персонажи")
                
                gamePicker.padding(.horizontal)
                
                if vm.isShowingNoFavoritesView() {
                    noFavoritesView
                } else {
                    rolesList
                }
                
            }
            rolesTabBar
        }
        .onChange(of: vm.game) { _ in vm.refreshTotalCharacters() }
    }
}

struct CharactersView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersView()
            .preferredColorScheme(.dark)
            .environmentObject(MainViewViewModel())
    }
}


// MARK: COMPONENTS

extension CharactersView {
    
    private var gamePicker: some View {
        Picker(selection: $vm.game, label: Text("Picker")) {
            Text("Классика").tag(GameType.base)
            Text("Избранные").tag(GameType.favorites)
            Text("Больше").tag(GameType.more)
        }
        .pickerStyle(.segmented)
    }
    
    private var rolesList: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: vm.columns) {
                ForEach(
                    vm.game == .base
                    ? $vm.selectedBaseCharacters
                    : vm.game == .favorites
                    ? $vm.favoritesCharacters
                    : $vm.selectedMoreCharacters,
                    id: \.self)
                { character in
                    CharacterCardView(
                        character: character,
                        totalCount: $vm.totalCharacters
                    )
                }
                .padding()
            }
        }
        .padding(.bottom, UIScreen.main.bounds.height / 18)
    }
    
    private var rolesTabBar: some View {
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
    
    private var noFavoritesView: some View {
        VStack {
            Spacer()
            Text("Нет избранных").font(.title2)
            Spacer()
            Spacer()
        }
    }
    
    private var playersCounter: some View {
        Text("\(vm.totalCharacters)/\(vm.playersForGame.count)")
            .bold()
            .font(
                .system(
                    size: vm.totalCharacters == vm.playersForGame.count
                    ?  UIScreen.main.bounds.height / 45
                    :  UIScreen.main.bounds.height / 50
                )
            )
            .opacity(vm.section == .characters ? 1 : 0)
            .foregroundColor(vm.totalCharacters == vm.playersForGame.count
                             ? . green : .white)
    }
    
}

