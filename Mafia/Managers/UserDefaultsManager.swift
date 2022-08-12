//
//  UserDefaultsManager.swift
//  Mafia
//
//  Created by Ульяна Гритчина on 07.08.2022.
//

import Foundation

//class UserDefaultsManager {
//    
//    static let instance = UserDefaultsManager()
//    private init() { }
//    
//    func addCharacter(name: String) {
//        var ch = UserDefaults.standard.array(forKey: "characters")
//        if let c = ch {
//            if !c.isEmpty {
//                var cha: [Any] = ch ?? []
//                cha.append(name)
//                UserDefaults.standard.set(cha, forKey: "characters")
//                print("\(UserDefaults.standard.array(forKey: "characters"))")
//            }
//        } else {
//            let ne = [name]
//            UserDefaults.standard.set(ne, forKey: "characters")
//        }
//        
//       
//    }
//    
//}
