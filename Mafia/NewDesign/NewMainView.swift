//
//  NewMainView.swift
//  Mafia
//
//  Created by Ульяна Гритчина on 06.01.2023.
//

import SwiftUI

class NewMainViewModel: ObservableObject {
    
}

struct NewMainView: View {
    @StateObject var vm: NewMainViewModel = NewMainViewModel()
    @State private var players = Array(repeating: "", count: 30)
    private let width = UIScreen.main.bounds.width
    private let height = UIScreen.main.bounds.height
    var body: some View {
        ZStack {
            Color("background")
            VStack {
                HStack {
                    Text("Мафия")
                        .font(.system(size: 30, weight: .medium, design: .serif))
                    Spacer()
                }
                
                VStack(spacing: 0) {
                    Text("Игроки")
                        .font(.system(size: 20, weight: .medium, design: .serif))
                    ScrollView(showsIndicators: false) {
                        Rectangle()
                            .frame(height: 10)
                            .opacity(0)
                        ForEach(0..<30, id: \.self) { index in
                            PlayerNameTF(playerName: $players[index], index: index + 1)
                                .padding(.bottom)
                        }
                    }
                }
                .padding(.top, 5)
  
            }
            .padding()
            .padding(.top, 45)
            
            VStack {
                Spacer()
                Rectangle()
                    .frame(width: width, height: height / 8)
                    .foregroundColor(Color("tabBar"))
                    .cornerRadius(10)
            }
        }
        .ignoresSafeArea()
       // .preferredColorScheme(.dark)
        
    }
}

struct NewMainView_Previews: PreviewProvider {
    static var previews: some View {
        NewMainView()
    }
}

//MARK: - VIEW COMPONENTS

extension NewMainView {
    
    
}
