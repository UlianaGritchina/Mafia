import SwiftUI

struct RoleCardView: View {
    let player: Player
    @State private var isShowingRole = false
    private let width = UIScreen.main.bounds.width
    private let height = UIScreen.main.bounds.height
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
        RoleCardView(player: Player(name: "name", role: "role"))
    }
}

extension RoleCardView {
    
    var roleCircle: some View {
        Circle()
            .frame(width: width / 2,
                   height: height / 2)
            .shadow(color: .white.opacity(0.5), radius: 15, x: 0, y: 0)
            .overlay(
                VStack {
                    Text(player.role)
                        .bold()
                        .foregroundColor(.black)
                        .font(.system(size: height / 30))
                }
            )
    }
    
    var nameRect: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: width / 1.5,
                       height: height / 2.3)
                .foregroundColor(.black)
                .overlay(
                    ZStack {
                        VStack {
                            Text(player.name)
                                .bold()
                                .foregroundColor(.white)
                                .font(.system(size: height / 30))
                            Spacer()
                            Text("?")
                                .foregroundColor(.white)
                                .bold()
                                .font(.system(size: height / 8))
                            Spacer()
                        }
                        .padding()
                        RoundedRectangle(cornerRadius: 20)
                            .stroke()
                            .opacity(0.6)
                    }
                )
                .rotationEffect(Angle(degrees: isShowingRole ? -80 : 0))
                .offset(x: isShowingRole ? width / 2 : 0,
                        y: isShowingRole ? -height / 4 : 0)
                .animation(.spring(), value: isShowingRole)
        }
    }
    
}
