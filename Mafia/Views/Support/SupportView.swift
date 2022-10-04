import SwiftUI

struct SupportView: View {
    var body: some View {
        NavigationView {
            VStack {
                ReviewButton()
            }
            .navigationTitle("Поддержка")
        }
        .preferredColorScheme(.dark)
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        SupportView()
    }
}
