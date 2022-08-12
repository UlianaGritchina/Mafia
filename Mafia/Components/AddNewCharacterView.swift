//
//  AddNewCharacterView.swift
//  Mafia
//
//  Created by Ульяна Гритчина on 06.08.2022.
//

import SwiftUI

struct AddNewCharacterView: View {
    @State private var name = ""
    let height = UIScreen.main.bounds.height
    let width = UIScreen.main.bounds.width
    var body: some View {
        NavigationView {
            VStack {
                TextField("Имя", text: $name)
                    .font(.system(size: height / 30))
                    .multilineTextAlignment(.center)
                    .padding()
                Spacer()
                CustomButton(title: "Сохранить",
                             color: .blue,
                             action: {},
                             width: width - 80)
                    .padding()
            }
            .navigationTitle("Новый персонаж")
            .preferredColorScheme(.dark)
        }
    }
    
    //func addNewCharacter() {
        //UserDefaultsManager.instance.addCharacter(name: name)
    //}
}

struct AddNewCharacterView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewCharacterView()
    }
}
