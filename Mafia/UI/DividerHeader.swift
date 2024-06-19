//
//  DividerHeader.swift
//  Mafia
//
//  Created by Ульяна Гритчина on 19.06.2024.
//

import SwiftUI

struct DividerHeader: View {
    let title: String
    var body: some View {
        VStack {
            Text(title.localised)
                .font(.system(size: 18, weight: .bold, design: .serif))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top)
            Divider()
                .padding(.horizontal)
        }
    }
}

#Preview {
    DividerHeader(title: "Main")
}
