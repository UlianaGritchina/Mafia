import Foundation

class UserDefaultsManager {
    
    static let instance = UserDefaultsManager()
    private init() { }
    
    func addCharacter(name: String) {
        let characters = UserDefaults.standard.array(forKey: "characters")
        if let characters = characters {
            if !characters.isEmpty {
                var newCharacters: [Any] = characters
                newCharacters.append(name)
                UserDefaults.standard.set(newCharacters, forKey: "characters")
            }
        } else {
            let newCharacter = [name]
            UserDefaults.standard.set(newCharacter, forKey: "characters")
        }
    }
    
}
