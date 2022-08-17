import SwiftUI

class AddNewCharacterViewViewModel: ObservableObject {
   
    @Published var name = ""
    
    func save() {
        UserDefaultsManager.instance.addCharacter(name: name)
        print(UserDefaults.standard.array(forKey: "characters"))
    }
    
}
