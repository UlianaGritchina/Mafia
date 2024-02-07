//
//  PlayerRoleView.swift
//  Mafia
//
//  Created by Ульяна Гритчина on 06.02.2024.
//

import SwiftUI

struct PlayerRoleView: View {
    @State private var isFlipped = false
    @State private var backDegree = 0.0
    @State private var frontDegree = -90.0
    var body: some View {
        ZStack {
            Image("Mafia")
                .resizable()
                .scaledToFill()
                .frame(
                    width: UIScreen.main.bounds.width / 1.2,
                    height: UIScreen.main.bounds.height / 2.1
                )
                .cornerRadius(20)
                .overlay {
                    ZStack(alignment: .bottom) {
                        Text("Mafia")
                            .font(.system(size: 30, weight: .bold, design: .monospaced))
                            .padding(.bottom)
                            .frame(maxWidth: .infinity)
                            .padding(.top, 3)
                            .background(.ultraThinMaterial)
                            .cornerRadius(20)
                        LinearGradient(colors: [.white, .white.opacity(0.4)], startPoint: .bottom, endPoint: .top)
                            .mask {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke()
                                    .opacity(0.5)
                                
                            }
                            .cornerRadius(20)
                    }
                }
            
                .rotation3DEffect(
                    Angle(degrees: frontDegree),
                    axis: (x: 0.001, y: 1, z: 0.001)
                )
            
            Image("mafiaheat")
                .resizable()
                .scaledToFill()
                .frame(
                    width: UIScreen.main.bounds.width / 1.2,
                    height: UIScreen.main.bounds.height / 2.1
                )
                .cornerRadius(20)
                .overlay {
                    ZStack(alignment: .bottom) {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.black)
                            .opacity(0.5)
                        Text("Uliana")
                            .font(.system(size: 30, weight: .bold, design: .monospaced))
                            .padding(.bottom)
                            .opacity(0.85)
                            .multilineTextAlignment(.center)
                        LinearGradient(colors: [.white, .white.opacity(0.4)], startPoint: .bottom, endPoint: .top)
                            .mask {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke()
                                    .opacity(0.5)
                                
                            }
                            .cornerRadius(20)
                    }
                }
                .preferredColorScheme(.dark)
                .rotation3DEffect(
                    Angle(degrees: backDegree),
                    axis: (x: 0.001, y: 1, z: 0.001)
                )
        }
        
        .onTapGesture {
            flipCard()
            
        }
    }
    
    func flipCard () {
        isFlipped = !isFlipped
        if isFlipped {
            withAnimation(.linear(duration: 0.1)) {
                backDegree = 90
            }
            withAnimation(.spring().delay(0.1)){
                frontDegree = 0
            }
        } else {
            withAnimation(.linear(duration: 0.1)) {
                frontDegree = -90
            }
            withAnimation(.spring().delay(0.1)){
                backDegree = 0
            }
        }
    }
}

#Preview {
    PlayerRoleView()
}
