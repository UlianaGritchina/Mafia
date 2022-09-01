import SwiftUI

struct FinalEasterEggView: View {
    private let width = UIScreen.main.bounds.width
    private let height = UIScreen.main.bounds.height
    @Environment(\.presentationMode) var presentationMode
    @State private var isBig = false
    var body: some View {
        VStack {
            HStack {
                Spacer()
                exitButton
            }
            .padding()
            
            Spacer()
            Link(destination: URL(string: "https://api.github.com/octocat")!) {
                rectangle
                    .overlay(octocat)
                    .offset(x: 0, y: isBig ? -30 : 0)
            }
            Spacer()
            
        }
        .onAppear {
            withAnimation(
                Animation
                    .easeInOut(duration: 2)
                    .repeatForever()
            ) {
                isBig.toggle()
            }
        }
    }
}

struct FinalEasterEggView_Previews: PreviewProvider {
    static var previews: some View {
        FinalEasterEggView()
            .preferredColorScheme(.dark)
    }
}


extension FinalEasterEggView {
    
    private var rectangle: some View {
        RoundedRectangle(cornerRadius: isBig ? 120 : 25)
            .frame(width: isBig ? 200 : 140, height: isBig ? 200 : 140)
            .foregroundColor(.white)
            .shadow(color: .purple.opacity(isBig ? 1 : 0.5),
                    radius: isBig ? 20 : 5, x: 0, y: 0)
    }
    
    private var octocat: some View {
        Image("octocat")
            .resizable()
            .scaledToFill()
            .shadow(color: .purple.opacity(isBig ? 1 : 0), radius: 5, x: 0, y: 0)
    }
    
    private var exitButton: some View {
        Button(action: {presentationMode.wrappedValue.dismiss()}) {
            Text("Выйти")
                .foregroundColor(.black)
                .frame(width: 60, height: 30)
                .background(Color.white)
                .cornerRadius(5)
        }
        
    }
}

