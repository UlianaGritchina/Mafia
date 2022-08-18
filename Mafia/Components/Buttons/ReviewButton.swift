import SwiftUI

struct ReviewButton: View {
    private let width = UIScreen.main.bounds.width
    private let height = UIScreen.main.bounds.height
    var body: some View {
        Button(action: {}) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: width / 1.5, height: height / 20)
                    .foregroundColor(Color("Color"))
            
                Link(destination: URL(string: "https://apps.apple.com/ru/app/mafia-gang/id1638964730")!) {
                    Text("Написать отзыв")
                        .bold()
                        .font(.system(size: height / 45))
                        .foregroundColor(.white)
                        .frame(width: width / 2.5, height: height / 20)
                }
            }
        }
    }
}

struct ReviewButton_Previews: PreviewProvider {
    static var previews: some View {
        ReviewButton()
    }
}
