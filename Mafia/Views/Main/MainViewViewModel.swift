
import SwiftUI

enum GameType: String, CaseIterable, Identifiable {
    case base
    case more
    
    var id: String { self.rawValue }
}

class MainViewViewModel: ObservableObject {
    
    @Published var players = Array(repeating: "", count: 30)
    @Published var game: GameType = .base
    @Published var isPlayersView = true
    @Published var isStartView = false
    @Published var isShowingInfo = false
    
    let baseCharacters = ["Мафия","Шериф","Мирные жители"]
    let characters = [
        "Дон","Мафия","Шериф","Мирные жители","Доктор","Маньяк","Любовница"
    ]
    let columns: [GridItem] = [
        GridItem(.adaptive(minimum: UIScreen.main.bounds.width / 3, maximum: 700))
    ]
    
    func showRolesView() {
        isPlayersView.toggle()
        UIApplication.shared.endEditing()
    }
    
}
