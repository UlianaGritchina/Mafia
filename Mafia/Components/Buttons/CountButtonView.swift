//
//  CountButtonView.swift
//  Mafia
//
//  Created by Ульяна Гритчина on 23.07.2022.
//

import SwiftUI

struct CountButtonView: View {
    let sign: String
    let action: () -> ()
    var body: some View {
        Button(action: action) {
            Text(sign)
                .bold()
                .font(.system(size: UIScreen.main.bounds.height / 30))
                .foregroundColor(.gray)
        }
    }
}

struct CountButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CountButtonView(sign: "+", action: {})
    }
}
