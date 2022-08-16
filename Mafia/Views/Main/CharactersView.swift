//
//  CharactersView.swift
//  Mafia
//
//  Created by Ульяна Гритчина on 15.08.2022.
//

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
    }
}

struct CharactersView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersView(vm: MainViewViewModel())
    }
}

extension CharactersView {
    
    var gamePicker: some View {
        Picker(selection: $vm.game, label: Text("Picker")) {
            Text("Классика").tag(GameType.base)
            Text("Больше").tag(GameType.more)
        }
        .pickerStyle(.segmented)
    }
    
    var rolesList: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: vm.columns) {
                ForEach(vm.game == .base
                        ? $vm.baseCharacters
                        : $vm.moreCharacters, id: \.self) { character in
                    
                    CharacterCardView(
                        character: character,
                        totalCount: $vm.totalCharacters
                    )
                        .padding()
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
