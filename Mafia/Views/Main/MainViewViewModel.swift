
import SwiftUI

enum GameType: String, CaseIterable, Identifiable {
    case base
    case more
    
    var id: String { self.rawValue }
}

class MainViewViewModel: ObservableObject {
    
    @Published var players = Array(repeating: "", count: 30)
    @Published var playersForGame: [String] = []
    @Published var game: GameType = .base
    @Published var totalCharacters = 0
    @Published var isPlayersView = true
    @Published var isStartView = false
    @Published var isShowingAlert = false
    
    var restBase: [Character] = [
        Character(name: "Мафия", count: 0),
        Character(name: "Шериф", count: 0),
        Character(name: "Мирный", count: 0)
    ]
    var restMore: [Character] = [
        Character(name: "Дон", count: 0),
        Character(name: "Мафия", count: 0),
        Character(name: "Шериф", count: 0),
        Character(name: "Мирный", count: 0),
        Character(name: "Доктор", count: 0),
        Character(name: "Маньяк", count: 0),
        Character(name: "Любовница", count: 0)
    ]
    
    @Published var baseCharacters: [Character] = []
    @Published var moreCharacters: [Character] = []
    
    var roles: [String] = []
    var results: [Player] = []
    let columns: [GridItem] = [
        GridItem(.adaptive(minimum: UIScreen.main.bounds.width / 3, maximum: 700))
    ]
    
    init() {
        baseCharacters = restBase
        moreCharacters = restMore
    }
    
    private func getRoles() {
        for character in game == .base ? baseCharacters : moreCharacters {
            roles.append(
                contentsOf: repeatElement(character.name, count: character.count)
            )
        }
        roles.shuffle()
    }
    
    private func getResults() {
        for index in 0..<roles.count {
            results.append(Player(name: playersForGame[index],
                                  role: roles[index]))
        }
    }
    
    func showRolesView() {
        isPlayersView.toggle()
    }
    
    func next() {
        playersForGame.removeAll()
        for player in players {
            if !player.isEmpty {
                playersForGame.append(player)
            }
        }
        if playersForGame.count > 0 {
            HapticManager.instance.impact(style: .soft)
            isPlayersView.toggle()
        } else {
            showAlert()
            HapticManager.instance.notification(type: .warning)
        }
    }
    
    func showAlert() {
        isShowingAlert = true
    }
    
    func start() {
        if canStart() {
            roles.removeAll()
            results.removeAll()
            getRoles()
            getResults()
            isStartView.toggle()
            HapticManager.instance.impact(style: .soft)
        }
    }
    
    
    
    func back() {
        isPlayersView.toggle()
    }
    
    func canStart() -> Bool {
        totalCharacters == playersForGame.count
    }
    
    func restCharacters() {
        baseCharacters = restBase
        moreCharacters = restMore
        totalCharacters = 0
    }
    
}
