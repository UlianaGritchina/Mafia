//
//  GameView.swift
//  Mafia
//
//  Created by Ульяна Гритчина on 23.07.2022.
//

import SwiftUI

class GameViewViewModel: ObservableObject {
    let columns: [GridItem] = [
        GridItem(.adaptive(minimum: UIScreen.main.bounds.width / 3, maximum: 700))
    ]
    
    @Published var isShowingRole = false
    
}

struct GameView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var vm = GameViewViewModel()
    var body: some View {
        NavigationView {
            VStack {
                ScrollView{
                    ForEach(0..<10) { index in
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .frame(width: UIScreen.main.bounds.width / 2,
                                       height: UIScreen.main.bounds.height / 3)
                                .overlay(
                                    VStack {
                                        Text("Мафия")
                                            .bold()
                                            .foregroundColor(.black)
                                    }
                                )
                                .onTapGesture {
                                    vm.isShowingRole.toggle()
                                }
                            RoundedRectangle(cornerRadius: 20)
                                .frame(width: UIScreen.main.bounds.width / 2,
                                       height: UIScreen.main.bounds.height / 3)
                                .foregroundColor(.black)
                                .shadow(color: .white.opacity(0.7), radius: 5, x: 0, y: 0)
                                .padding()
                                .overlay(
                                    VStack {
                                        Text("Name")
                                            .bold()
                                            .foregroundColor(.white)
                                            .font(.system(size: UIScreen.main.bounds.height / 30))
                                            .padding(.top)
                                        Spacer()
                                        Text("?")
                                            .bold()
                                            .font(.system(size: UIScreen.main.bounds.height / 10))
                                        Spacer()
                                    }
                                        .padding()
                                )
                                .onTapGesture {
                                    vm.isShowingRole.toggle()
                                }
                                .rotationEffect(Angle(degrees: vm.isShowingRole ? -70 : 0))
                                .offset(x: vm.isShowingRole ? 190 : 0,
                                        y: vm.isShowingRole ? -140 : 0)
                                .animation(.spring(), value: vm.isShowingRole)
                        }
                        .padding(.horizontal, UIScreen.main.bounds.width)
                        
                        
                    }
                }
            }
            .navigationTitle("Игра")
            .preferredColorScheme(.dark)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {}) {
                        Image(systemName: "list.dash")
                    }
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button("Готово") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
