//
//  Extension+UIApplication.swift
//  Mafia
//
//  Created by Ульяна Гритчина on 02.08.2022.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder),
                   to: nil, from: nil, for: nil)
    }
}
