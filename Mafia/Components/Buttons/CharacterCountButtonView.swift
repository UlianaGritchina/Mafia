import SwiftUI

struct CharacterCountButtonView: View {
    let sign: String
    let action: () -> ()
    var body: some View {
        Button(action: action) {
            Text(sign)
                .bold()
                .font(.system(size: UIScreen.main.bounds.height / 30))
                .foregroundColor(.gray)
        }
    }
}

struct CountButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterCountButtonView(sign: "+", action: {})
    }
}
