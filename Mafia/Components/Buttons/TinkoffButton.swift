//
//  TinkoffButtonView.swift
//  Mafia
//
//  Created by Ульяна Гритчина on 15.08.2022.
//

import SwiftUI

struct TinkoffButton: View {
    private let width = UIScreen.main.bounds.width
    private let height = UIScreen.main.bounds.height
    var body: some View {
        Button(action: {}) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: width / 1.5, height: height / 20)
                    .foregroundColor(Color("tinkoff"))
                
                Link(destination: URL(string: "https://www.tinkoff.ru/cf/1yvFPYgx2ff")!) {
                    Text("Tinkoff")
                        .bold()
                        .font(.system(size: height / 45))
                        .foregroundColor(.black)
                        .frame(width: width / 1.5, height: height / 20)
                }
            }
        }
    }
}

struct TinkoffButton_Previews: PreviewProvider {
    static var previews: some View {
        TinkoffButton()
    }
}
