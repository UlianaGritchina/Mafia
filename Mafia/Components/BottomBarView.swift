import SwiftUI

struct BottomBarView: View {
    var body: some View {
        Rectangle()
            .frame(width: UIScreen.main.bounds.width,
                   height: UIScreen.main.bounds.height / 10)
            .opacity(0.2)
            .background(.ultraThinMaterial)
            .cornerRadius(10)
    }
}

struct BackRectView_Previews: PreviewProvider {
    static var previews: some View {
        BottomBarView()
    }
}
