import SwiftUI

struct ContextMenuButton: View {
    @EnvironmentObject var vm: MainViewViewModel
    let character: Character
    var body: some View {
        Button(action: {
            if vm.game != .favorites {
                vm.add(character)
            } else {
                withAnimation {
                    vm.delete(character)
                }
            }
        }) {
            Text(vm.game != .favorites
                 ? "Добавить в избранные"
                 : "Удалить из избранных")
        }
    }
}

struct ContextMenuButton_Previews: PreviewProvider {
    static var previews: some View {
        ContextMenuButton(
            character: Character(name: "name", count: 0)
        )
            .environmentObject(MainViewViewModel())
    }
}
