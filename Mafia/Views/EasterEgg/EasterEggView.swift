import SwiftUI

struct EasterEggView: View {
    var body: some View {
        ZStack {
            EggsView()
                .frame(width: 200, height: 200)
        }
    }
}

struct EasterEggView_Previews: PreviewProvider {
    static var previews: some View {
        EasterEggView()
    }
}
