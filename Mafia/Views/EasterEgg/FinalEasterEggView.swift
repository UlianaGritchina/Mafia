import SwiftUI

struct FinalEasterEggView: View {
    private let width = UIScreen.main.bounds.width
    private let height = UIScreen.main.bounds.height
    var body: some View {
        Link(destination: URL(string: "")!) {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.red)
                .frame(width: width / 2.5, height: height / 20)
        }
    }
}

struct FinalEasterEggView_Previews: PreviewProvider {
    static var previews: some View {
        FinalEasterEggView()
    }
}
