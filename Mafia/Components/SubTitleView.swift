import SwiftUI

struct SubTitleView: View {
    let text: String
    var body: some View {
        ZStack {
            Rectangle()
                .opacity(0.2)
                .background(.ultraThinMaterial)
                .cornerRadius(10)
                .ignoresSafeArea()
            VStack {
                HStack {
                    Text("Мафия")
                        .font(.system(size: 35, weight: .bold, design: .serif))
                    Spacer()
                }
                Text(text)
                    .font(.system(size: 23, weight: .medium, design: .serif))
            }
            .padding(.horizontal)
        }
        .frame(
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.height / 10
        )
    }
}

struct PodTitleView_Previews: PreviewProvider {
    static var previews: some View {
        SubTitleView(text: "some title")
    }
}
