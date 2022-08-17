import SwiftUI

struct SubTitleView: View {
    let text: String
    var body: some View {
        Text(text)
            .bold()
            .font(.system(size: UIScreen.main.bounds.height / 35))
    }
}

struct PodTitleView_Previews: PreviewProvider {
    static var previews: some View {
        SubTitleView(text: "some title")
    }
}
