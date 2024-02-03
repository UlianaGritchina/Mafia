//
//  StartView.swift
//  Mafia
//
//  Created by Uliana Gritchina on 02.02.2024.
//

import SwiftUI

struct StartView: View {
    @StateObject private var viewModel = ViewModel()
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 20) {
                title
                charactersSection
                playButton
                    .padding(.top, 30)
            }
            .padding(.top, UIScreen.main.bounds.height / 20)
        }
        .background(backgroundImage)
        .padding(.horizontal)
        .preferredColorScheme(.dark)
        .sheet(isPresented: $viewModel.isShowCharactersView) {
            CharactersList()
        }
    }
}

#Preview {
    StartView()
}

extension StartView {
    
    private var title: some View {
        Text("MAFIA")
            .font(.system(size: 30, weight: .bold, design: .serif))
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var backgroundImage: some View {
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
    
    private var charactersSection: some View {
        Button(action: { viewModel.showCharacters() }) {
            VStack(spacing: 15) {
                charactersPreview
                Text("See characters")
                    .foregroundStyle(.white)
                    .font(.system(size: 20, weight: .bold, design: .serif))
            }
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(ScaleButtonStyle())
    }
    
    private var playButton: some View {
        Button(action: {}, label: {
            Text("Play")
                .foregroundStyle(.white)
                .font(.system(size: 26, weight: .bold, design: .serif))
        })
    }
    
    private var charactersPreview: some View {
        ZStack {
            CharacterCard(
                imageName: viewModel.characters[0].imageName,
                size: UIScreen.main.bounds.width / 2.8,
                offset: -100,
                isShowGradient: true
            )
            
            CharacterCard(
                imageName: viewModel.characters[1].imageName,
                size: UIScreen.main.bounds.width / 2.8,
                offset: 100,
                isShowGradient: true
            )
            CharacterCard(
                imageName: viewModel.characters[2].imageName,
                size: UIScreen.main.bounds.width / 2.5
            )
        }
    }
    
    struct CharacterCard: View {
        let imageName: String
        let size: CGFloat
        let offset: CGFloat
        let isShowGradient: Bool
        
        init(imageName: String, size: CGFloat, offset: CGFloat = 0, isShowGradient: Bool = false) {
            self.imageName = imageName
            self.size = size
            self.offset = offset
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
                .offset(x: offset)
        }
    }
}

struct SpecialNavBar: ViewModifier {
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.font: UIFont(name: "HelveticaNeue-Bold", size: 30)!]
    }
    
    func body(content: Content) -> some View {
        content
    }
}

extension View {
    func specialNavBar() -> some View {
        self.modifier(SpecialNavBar())
    }
}
