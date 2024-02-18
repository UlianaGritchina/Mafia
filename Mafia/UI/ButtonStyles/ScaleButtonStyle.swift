//
//  ScaleButtonStyle.swift
//  Mafia
//
//  Created by Uliana Gritchina on 03.02.2024.
//

import SwiftUI

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.linear(duration: 0.1), value: configuration.isPressed)
            .brightness(configuration.isPressed ? -0.05 : 0)
    }
}

struct GrayButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 16)
            .background(Color.gray.opacity(0.7))
            .cornerRadius(5)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.linear(duration: 0.1), value: configuration.isPressed)
            .brightness(configuration.isPressed ? -0.05 : 0)
    }
}
