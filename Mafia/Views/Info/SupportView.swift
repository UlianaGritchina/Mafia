//
//  InfoView.swift
//  Mafia
//
//  Created by Ульяна Гритчина on 15.08.2022.
//

import SwiftUI

struct SupportView: View {
    var body: some View {
        NavigationView {
            VStack {
                TinkoffButton().padding()
                ReviewButton().padding()
            }
            .navigationTitle("Поддержка")
        }
        .preferredColorScheme(.dark)
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        SupportView()
    }
}
