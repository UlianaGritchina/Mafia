//
//  BackRectView.swift
//  Mafia
//
//  Created by Ульяна Гритчина on 02.08.2022.
//

import SwiftUI

struct BackRectView: View {
    var body: some View {
        Rectangle()
            .frame(width: UIScreen.main.bounds.width,
                   height: UIScreen.main.bounds.height / 10)
            .opacity(0)
            .background(.ultraThinMaterial)
            .cornerRadius(10)
    }
}

struct BackRectView_Previews: PreviewProvider {
    static var previews: some View {
        BackRectView()
    }
}
