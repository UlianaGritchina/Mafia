//
//  SettingsView.swift
//  Mafia
//
//  Created by Ульяна Гритчина on 18.06.2024.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject private var viewModel = ViewModel()
    
    @EnvironmentObject private var appearanceManager: AppearanceManager
    
    var body: some View {
        ScrollView {
            VStack {
                header
                VStack(spacing: 45) {
                    backgroundImageSection
                    feedback
                }
            }
        }
        .background(BackgroundImage().environmentObject(appearanceManager))
        .preferredColorScheme(.dark)
    }
}

#Preview {
    SettingsView()
}

extension SettingsView {
    
    private var header: some View {
        HStack {
            Text("Settings")
                .font(.system(size: 30, weight: .bold, design: .serif))
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            Button(action: { presentationMode.wrappedValue.dismiss() }) {
                Image(systemName: "xmark")
                    .font(.title2)
            }
        }
        .padding()
        .padding(.top)
    }
    
    private var backgroundImageSection: some View {
        VStack(alignment: .leading) {
            Text("Background")
                .font(.system(size: 18, weight: .bold, design: .serif))
                .padding(.horizontal)
            Divider()
                .padding(.horizontal)
            imagesList
        }
    }
    
    private var feedback: some View {
        VStack(spacing: 15) {
            Text("Feedback")
                .font(.system(size: 18, weight: .bold, design: .serif))
                .frame(maxWidth: .infinity, alignment: .leading)
            Divider()
            VStack(spacing: 18) {
                writeReviewLink
                telegramButton
            }
        }
        .padding(.horizontal)
    }
    
    private var imagesList: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 15) {
                ForEach(viewModel.images, id: \.self) { image in
                    VStack {
                        Button(action: {
                            withAnimation {
                                appearanceManager.updateBackgroundImage(with: image)
                                viewModel.selectImage(image)
                            }
                        }) {
                            Image(image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 150)
                                .cornerRadius(10)
                        }
                        if image == viewModel.selectedImage {
                            Circle()
                                .frame(width: 10)
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
    }
    
    private var telegramButton: some View  {
        Link(destination: URL(string: "https://t.me/WorldWordsApp")!) {
            Text("Telegram")
                .font(.system(size: 18, weight: .bold, design: .serif))
        }
    }
    
    private var writeReviewLink: some View {
        Link(destination: viewModel.writeReviewURL) {
            Text("Rate the app")
                .font(.system(size: 18, weight: .bold, design: .serif))
        }
        .buttonStyle(ScaleButtonStyle())
    }
}
