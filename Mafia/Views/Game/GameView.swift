//
//  GameView.swift
//  Mafia
//
//  Created by Ульяна Гритчина on 23.07.2022.
//

import SwiftUI

class GameViewViewModel: ObservableObject {
    
}

struct GameView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var vm = GameViewViewModel()
    var body: some View {
        NavigationView {
            VStack {
                RoleCardView(name: "name", role: "role")
                Spacer()
                CustomButton(title: "Следующий",
                             color: .blue,
                             action: {},
                             width: UIScreen.main.bounds.width - 80)
            }
            .navigationTitle("Игра")
            .preferredColorScheme(.dark)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    NavigationLink(destination: RolesListView()) {
                        Image(systemName: "list.dash")
                    }
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button("Завершить") {
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
