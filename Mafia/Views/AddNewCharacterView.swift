//
//  AddNewCharacterView.swift
//  Mafia
//
//  Created by Ульяна Гритчина on 06.08.2022.
//

import SwiftUI

struct AddNewCharacterView: View {
    @StateObject var vm = AddNewCharacterViewViewModel()
    @Environment(\.presentationMode) var presentationMode
    let height = UIScreen.main.bounds.height
    let width = UIScreen.main.bounds.width
    var body: some View {
        NavigationView {
            VStack {
                characterTF
                Spacer()
                saveButton.padding()
            }
            .navigationTitle("Новый персонаж")
        }
        .preferredColorScheme(.dark)
        .onAppear {
            print(UserDefaults.standard.array(forKey: "characters"))
        }
    }
    
}

struct AddNewCharacterView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewCharacterView()
    }
}


extension AddNewCharacterView {
    
    var characterTF: some View {
        TextField("Персонаж", text: $vm.name)
            .font(.system(size: height / 30))
            .multilineTextAlignment(.center)
            .padding()
    }
    
    var saveButton: some View {
        CustomButton(
            title: "Сохранить",
            color: .blue,
            action: {
                vm.save()
                presentationMode.wrappedValue.dismiss()
            },
            width: width - 80)
    }
    
}
