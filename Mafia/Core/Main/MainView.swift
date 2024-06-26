//
//  StartView.swift
//  Mafia
//
//  Created by Uliana Gritchina on 02.02.2024.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = ViewModel()
    @StateObject private var appearanceManager = AppearanceManager()
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 20) {
                title
                VStack(spacing: UIScreen.main.bounds.height / 10) {
                    charactersSection
                    playButton
                    settingsButton
                }
            }
            .padding(.top, UIScreen.main.bounds.height / 20)
        }
        .background(
            BackgroundImage()
                .environmentObject(appearanceManager)
        )
        .padding(.horizontal)
        .preferredColorScheme(.dark)
        .sheet(
            isPresented: $viewModel.isShowCharactersView,
            onDismiss: {
                withAnimation {
                    viewModel.updateCharactersSet()
                }
            }
        ) {
            CharactersList()
                .environmentObject(appearanceManager)
        }
        .sheet(isPresented: $viewModel.isShowSettings) {
            SettingsView()
                .environmentObject(appearanceManager)
        }
        .fullScreenCover(isPresented: $viewModel.isPlay) {
            GameView()
                .environmentObject(appearanceManager)
        }
    }
}

#Preview {
    MainView()
}

extension MainView {
    
    private var title: some View {
        Text("MAFIA")
            .font(.system(size: 30, weight: .bold, design: .serif))
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var charactersSection: some View {
        Button(action: { viewModel.showCharacters() }) {
            VStack(spacing: 15) {
                charactersPreview
                Text("See roles")
                    .foregroundStyle(.white)
                    .font(.system(size: 18, weight: .bold, design: .serif))
            }
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(ScaleButtonStyle())
    }
    
    private var playButton: some View {
        Button(action: { viewModel.playButtonTapped() }) {
            Text("Play")
                .foregroundStyle(.white)
                .font(.system(size: 31, weight: .bold, design: .serif))
        }
    }
    
    private var charactersPreview: some View {
        ZStack {
            CharacterCard(
                imageName: "doctor" + viewModel.charactersSet.rawValue,
                size: UIScreen.main.bounds.width / 2.8,
                isShowGradient: true
            )
            .offset(x: -100)
            
            CharacterCard(
                imageName: "sheriff" + viewModel.charactersSet.rawValue,
                size: UIScreen.main.bounds.width / 2.8,
                isShowGradient: true
            )
            .offset(x: 100)
            
            CharacterCard(
                imageName: "mafia" + viewModel.charactersSet.rawValue,
                size: UIScreen.main.bounds.width / 2.5
            )
        }
    }
    
    private var settingsButton: some View {
        Button(action: { viewModel.openSettings() }) {
            Text("Settings")
                .font(.system(size: 20, weight: .bold, design: .serif))
        }
        .padding(.bottom)
    }
    
    struct CharacterCard: View {
        let imageName: String
        let size: CGFloat
        let isShowGradient: Bool
        
        init(imageName: String, size: CGFloat, isShowGradient: Bool = false) {
            self.imageName = imageName
            self.size = size
            self.isShowGradient = isShowGradient
        }
        
        var body: some View {
            Image(imageName)
                .resizable()
                .frame(width: size, height: size)
                .overlay {
                    if isShowGradient {
                        LinearGradient(
                            colors: [.black.opacity(0.7), .black.opacity(0.3)],
                            startPoint: .bottom,
                            endPoint: .top
                        )
                    }
                }
                .cornerRadius(10)
        }
    }
}
