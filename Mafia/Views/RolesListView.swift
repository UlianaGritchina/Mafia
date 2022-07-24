//
//  RolesListView.swift
//  Mafia
//
//  Created by Ульяна Гритчина on 24.07.2022.
//

import SwiftUI

struct RolesListView: View {
    var body: some View {
            List {
                ForEach(0..<10) { index in
                    HStack {
                        Text("Ульяна")
                            .font(.system(size: UIScreen.main.bounds.height / 45))
                        Text("Мафия")
                            .bold()
                            .font(.system(size: UIScreen.main.bounds.height / 45))
                            .padding(.horizontal)
                    }
                }
        }
    }
}

struct RolesListView_Previews: PreviewProvider {
    static var previews: some View {
        RolesListView()
    }
}
