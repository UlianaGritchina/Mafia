//
//  ContentView.swift
//  Mafia
//
//  Created by Ульяна Гритчина on 23.07.2022.
//

import SwiftUI

class MainViewViewModel: ObservableObject {
    @Published var isPlayersView = true
    @Published var isStartView = false
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
        }
    }
    
    var rolesView: some View {
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
            List {
                ForEach(1..<31) { index in
                    
                    Toggle(isOn: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Is On@*/.constant(true)/*@END_MENU_TOKEN@*/) {
                        Text("Мафия")
                    }
                    
                }
            }
            .listStyle(.inset)
            
            HStack {
                CustomButton(title: "Назад",
                             color: .blue,
                             action: {vm.isPlayersView.toggle()})
                CustomButton(title: "Начать",
                             color: .red,
                             action: {vm.isStartView.toggle()})
            }
        }
    }
    
}
