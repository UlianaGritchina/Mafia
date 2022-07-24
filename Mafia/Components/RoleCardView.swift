//
//  RoleCardView.swift
//  Mafia
//
//  Created by Ульяна Гритчина on 24.07.2022.
//

import SwiftUI

struct RoleCardView: View {
    let name: String
    let role: String
    @State private var isShowingRole = false
    var body: some View {
        ZStack {
            roleCircle
            nameRect
        }
        .onTapGesture {
            isShowingRole.toggle()
        }
    }
}

struct RoleCardView_Previews: PreviewProvider {
    static var previews: some View {
        RoleCardView(name: "name", role: "role")
    }
}

extension RoleCardView {
    
    var roleCircle: some View {
        Circle()
            .frame(width: UIScreen.main.bounds.width / 2,
                   height: UIScreen.main.bounds.height / 2)
            .shadow(color: .white.opacity(0.7), radius: 15, x: 0, y: 0)
            .overlay(
                VStack {
                    Text(role)
                        .bold()
                        .foregroundColor(.black)
                        .font(.system(size: UIScreen.main.bounds.height / 30))
                }
            )
    }
    
    var nameRect: some View {
        VStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: UIScreen.main.bounds.width / 1.5,
                       height: UIScreen.main.bounds.height / 2.2)
                .foregroundColor(.black)
                .shadow(color: .white.opacity(0.7), radius: 5, x: 0, y: 0)
                .overlay(
                    VStack {
                        Text(name)
                            .bold()
                            .foregroundColor(.white)
                            .font(.system(size: UIScreen.main.bounds.height / 30))
                            .padding(.top)
                        Spacer()
                        Text("?")
                            .foregroundColor(.white)
                            .bold()
                            .font(.system(size: UIScreen.main.bounds.height / 10))
                        Spacer()
                    }
                        .padding()
                )
                .rotationEffect(Angle(degrees: isShowingRole ? -80 : 0))
                .offset(x: isShowingRole ? UIScreen.main.bounds.width / 2 : 0,
                        y: isShowingRole ? -UIScreen.main.bounds.height / 4 : 0)
            .animation(.spring(), value: isShowingRole)
        }
    }
    
}
