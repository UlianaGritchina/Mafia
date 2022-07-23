//
//  ContentView.swift
//  Mafia
//
//  Created by Ульяна Гритчина on 23.07.2022.
//

import SwiftUI

class MainViewViewModel: ObservableObject {
    let characters = [
        "Дон","Мафия","Шериф","Мирные жители","Доктор","Маньяк","Любовница"
    ]
    let columns: [GridItem] = [
        GridItem(.adaptive(minimum: UIScreen.main.bounds.width / 3, maximum: 700))
    ]
    @Published var isPlayersView = false
    @Published var isStartView = false
    @Published var isShowingInfo = false
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
            .sheet(isPresented: $vm.isStartView, content: {
                GameView()
            })
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
    
    var playersView: some View {
        VStack {
            
            Text("Игроки")
                .bold()
                .font(.system(size: UIScreen.main.bounds.height / 35))
            
            
                .padding(.horizontal, UIScreen.main.bounds.width / 24)
            List {
                ForEach(1..<31) { index in
                    TextField("Игрок \(index)", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                        .font(.system(size: UIScreen.main.bounds.height / 40))
                }
            }
            .listStyle(.inset)
            
            CustomButton(title: "Продолжить",
                         color: .blue,
                         action: {vm.isPlayersView.toggle()},
                         width: UIScreen.main.bounds.width - 80)
                .padding(.bottom)
        }
    }
    
    var rolesView: some View {
        ZStack {
            VStack {
                
                Text("Персонажи")
                    .bold()
                    .font(.system(size: UIScreen.main.bounds.height / 35))
                
                
                Picker(selection: .constant(1), label: Text("Picker")) {
                    Text("Классика").tag(1)
                    Text("Все").tag(2)
                }
                .pickerStyle(.segmented)

                .padding(.horizontal, UIScreen.main.bounds.width / 24)
                
                ScrollView {
                    LazyVGrid(columns: vm.columns) {
                        ForEach(vm.characters, id: \.self) { character in
                            CharacterCardView(name: character)
                                .padding()
                        }
                    }
                }
                HStack {
                    CustomButton(title: "Назад",
                                 color: .blue,
                                 action: {vm.isPlayersView.toggle()})
                    Spacer()
                    CustomButton(title: "Начать",
                                 color: .red,
                                 action: {vm.isStartView.toggle()})
                }
                .padding(.horizontal)
                .padding(.bottom)
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
