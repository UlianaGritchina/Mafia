import Foundation

class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    private init() { }
    
    func saveCharacterData(_ data: Data, for key: String) {
        UserDefaults.standard.set(data, forKey: key)
    }
    
}
