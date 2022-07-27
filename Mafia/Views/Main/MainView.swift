//
//  ContentView.swift
//  Mafia
//
//  Created by Ульяна Гритчина on 23.07.2022.
//

import SwiftUI

enum GameType: String, CaseIterable, Identifiable {
    case base
    case more
    
    var id: String { self.rawValue }
}

class MainViewViewModel: ObservableObject {
    
    @Published var players = Array(repeating: "", count: 30)
    @Published var game: GameType = .base
    @Published var isPlayersView = true
    @Published var isStartView = false
    @Published var isShowingInfo = false
    
    let baseCharacters = ["Мафия","Шериф","Мирные жители"]
    let characters = [
        "Дон","Мафия","Шериф","Мирные жители","Доктор","Маньяк","Любовница"
    ]
    let columns: [GridItem] = [
        GridItem(.adaptive(minimum: UIScreen.main.bounds.width / 3, maximum: 700))
    ]
    
    func showRolesView() {
        isPlayersView.toggle()
        UIApplication.shared.endEditing()
    }
    
}

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
                    if !vm.isPlayersView {
                        Text("0/\(vm.players.count)")
                            .bold()
                            .font(.system(size: UIScreen.main.bounds.height / 50))
                    }
                }
            }
            .animation(.default, value: vm.isPlayersView)
            .navigationTitle("Мафия")
            //.navigationBarTitleDisplayMode(.inline)
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
    
    var playersView: some View {
        ZStack {
            VStack {
                Text("Игроки")
                    .bold()
                    .font(.title2)
                List {
                    ForEach(0..<30) { index in
                        TextField("Игрок \(index+1)", text: $vm.players[index])
                            .font(.system(size: UIScreen.main.bounds.height / 40))
                        
                    }
                    Text("").padding()
                    
                }
                .listStyle(.inset)
            }
            
            VStack {
                Spacer()
                Rectangle()
                    .frame(width: UIScreen.main.bounds.width,
                           height: UIScreen.main.bounds.height / 10)
                    .opacity(0)
                    .background(.ultraThinMaterial)
                    .cornerRadius(20)
                    .shadow(color: .white.opacity(0.5), radius: 5, x: 0, y: 0)
                    .overlay(CustomButton(title: "Продолжить",
                                          color: .blue,
                                          action: {vm.showRolesView()},
                                          width: UIScreen.main.bounds.width - 80))
            }
            .ignoresSafeArea()
            
        }
        
        
    }
    
    var rolesView: some View {
        ZStack {
            ZStack {
                VStack {
                    Text("Персонажи")
                        .bold()
                        .font(.system(size: UIScreen.main.bounds.height / 35))
                    
                    Picker(selection: $vm.game, label: Text("Picker")) {
                        Text("Классика").tag(GameType.base)
                        Text("Больше").tag(GameType.more)
                    }
                    .pickerStyle(.segmented)
                    
                    .padding(.horizontal, UIScreen.main.bounds.width / 24)
                    
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
                    
                    Text("").padding()
                }
                
                VStack {
                    Spacer()
                    Rectangle()
                        .frame(width: UIScreen.main.bounds.width,
                               height: UIScreen.main.bounds.height / 10)
                        .opacity(0)
                        .background(.ultraThinMaterial)
                        .cornerRadius(20)
                        .shadow(color: .white.opacity(0.5), radius: 5, x: 0, y: 0)
                        .overlay(HStack {
                            CustomButton(title: "Назад",
                                         color: .blue,
                                         action: {vm.isPlayersView.toggle()})
                            Spacer()
                            CustomButton(title: "Начать",
                                         color: .red,
                                         action: {vm.isStartView.toggle()})
                        }.padding())
                }
                .ignoresSafeArea()
            }
            
            Rectangle()
                .opacity(0)
                .background(.ultraThinMaterial)
                .cornerRadius(20)
                .frame(width: UIScreen.main.bounds.width,
                       height: UIScreen.main.bounds.height / 2)
                .offset(y: vm.isShowingInfo
                        ? UIScreen.main.bounds.height / 3
                        : UIScreen.main.bounds.height)
                .shadow(color: .white.opacity(0.5), radius: 5, x: 0, y: 0)
                .onTapGesture {
                    vm.isShowingInfo.toggle()
                }
                .animation(.spring(), value: vm.isShowingInfo)
        }
    }
    
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder),
                   to: nil, from: nil, for: nil)
    }
}
