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
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 50) {
                    charactersSection
                    playButton
                }
            }
            .navigationTitle("Mafia")
            .background(backgroundImage)
            .padding(.horizontal)
            .preferredColorScheme(.dark)
            .sheet(isPresented: $viewModel.isShowCharactersView) {
                CharactersList()
            }
        }
    }
}

#Preview {
    StartView()
}

extension StartView {
    
    private var backgroundImage: some View {
        Image("nightMoonCity")
            .resizable()
            .scaledToFill()
            .clipShape(.rect)
            .frame(
                width: UIScreen.main.bounds.width,
                height: UIScreen.main.bounds.height
            )
            .overlay {
                LinearGradient(
                    colors: [.black.opacity(0.9), .black.opacity(0.5)],
                    startPoint: .bottom,
                    endPoint: .top
                )
            }
            .ignoresSafeArea()
    }
    
    private var charactersSection: some View {
        VStack(spacing: 15) {
            charactersPreview
            seeCharactersButton
        }
        .padding(.top, 20)
    }
    
    private var playButton: some View {
        Button(action: {}, label: {
            Text("Play")
                .foregroundStyle(.white)
                .font(.system(size: 26, weight: .bold, design: .serif))
                .padding(.horizontal, 40)
                .frame(height: 55)
                .background(.ultraThinMaterial)
                .cornerRadius(10)
                .padding(.horizontal)
        })
        .padding(.top)
    }
    
    private var charactersPreview: some View {
        ZStack {
            CharacterCard(
                imageName: "Doctor",
                size: UIScreen.main.bounds.width / 2.8,
                offset: -100,
                isShowGradient: true
            )
            
            CharacterCard(
                imageName: "Sheriff",
                size: UIScreen.main.bounds.width / 2.8,
                offset: 100,
                isShowGradient: true
            )
            CharacterCard(
                imageName: "Mafia",
                size: UIScreen.main.bounds.width / 2.5
            )
        }
    }
    
    private var seeCharactersButton: some View {
        Button(action: { viewModel.showCharacters() }) {
            Text("See characters")
                .foregroundStyle(.white)
                .font(.system(size: 20, weight: .bold, design: .serif))
                .frame(maxWidth: 700)
                .frame(height: 45)
                .background(.ultraThinMaterial)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke()
                }
                .cornerRadius(10)
                .padding(.horizontal)
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
