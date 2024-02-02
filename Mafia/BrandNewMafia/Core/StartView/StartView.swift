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
            ZStack {
                backgroundImage
                
                VStack(spacing: 30) {
                    Spacer()
                    Button(action: { viewModel.showCharacters() }) {
                        Text("See characters")
                            .foregroundStyle(.white)
                            .font(.system(size: 20, weight: .bold, design: .serif))
                            .frame(maxWidth: 700)
                            .frame(height: 50)
                            .background(.ultraThinMaterial)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                    .padding()
                    Button(action: {}, label: {
                        Text("Start")
                            .foregroundStyle(.white)
                            .font(.system(size: 26, weight: .bold, design: .serif))
                            .frame(maxWidth: 700)
                            .frame(height: 55)
                            .background(.ultraThinMaterial)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    })
                }
                .padding(.bottom, UIScreen.main.bounds.height / 10)
            }
            .navigationTitle("Mafia")
            .ignoresSafeArea()
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
                    colors: [.black.opacity(0.9), .black.opacity(0.3)],
                    startPoint: .bottom,
                    endPoint: .top
                )
            }
    }
    
}
