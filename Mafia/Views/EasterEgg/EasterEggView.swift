import SwiftUI

struct EasterEggView: View {
    @EnvironmentObject var vm: MainViewViewModel
    var body: some View {
        ZStack {
            EggsView().frame(width: 200, height: 200)
        }
        .onTapGesture {
            vm.eggsCount += 1
        }
    }
}

struct EasterEggView_Previews: PreviewProvider {
    static var previews: some View {
        EasterEggView()
            .environmentObject(MainViewViewModel())
    }
}
