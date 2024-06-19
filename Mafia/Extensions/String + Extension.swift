//
//  String + Extension.swift
//  Mafia
//
//  Created by Ульяна Гритчина on 19.06.2024.
//

import Foundation

extension String {
    var localised: String {
        NSLocalizedString(self, comment: "")
    }
}
