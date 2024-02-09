//
//  BackgroundImage.swift
//  Mafia
//
//  Created by Ульяна Гритчина on 09.02.2024.
//

import SwiftUI

struct BackgroundImage: View {
    var body: some View {
        Image("nightMoonCity")
            .resizable()
            .scaledToFill()
            .clipShape(.rect)
            .frame(
                width: UIScreen.main.bounds.width,
                height: UIScreen.main.bounds.height
            )
            .blur(radius: 2)
            .overlay {
                LinearGradient(
                    colors: [.black.opacity(0.9), .black.opacity(0.7)],
                    startPoint: .bottom,
                    endPoint: .top
                )
            }
            .ignoresSafeArea()
    }
}

#Preview {
    BackgroundImage()
}
