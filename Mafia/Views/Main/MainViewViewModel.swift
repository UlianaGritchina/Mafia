import SwiftUI

enum GameType: String, CaseIterable, Identifiable {
    case base
    case more
    case favorites
    
    var id: String { self.rawValue }
}

enum MainViewSection {
    case players
    case characters
}

class MainViewViewModel: ObservableObject {
    
    // MARK: PROPERTIES
    
    @Published var players = Array(repeating: "", count: 30)
    @Published var playersForGame: [String] = []
    @Published var game: GameType = .base
    @Published var totalCharacters = 0
    @Published var isStartView = false
    @Published var isShowingAlert = false
    @Published var isShowingSupportView = false
    @Published var isFavoritesCharacters = false
    @Published var section: MainViewSection = .players
    @Published var isShowingEgg = false
    
    let transition: AnyTransition = .asymmetric(
        insertion: .move(edge: .trailing),
        removal: .move(edge: .leading)
    )
    let transition2: AnyTransition = .asymmetric(
        insertion: .move(edge: .leading),
        removal: .move(edge: .trailing)
    )
    
    var startBase: [Character] = GameDataManager.instance.startBaseCharacters
    var startMore: [Character] = GameDataManager.instance.startMoreCharacters
    
    var restFavorite: [Character] = []
    
    @Published var baseCharacters: [Character] = []
    @Published var moreCharacters: [Character] = []
    @Published var favoritesCharacters: [Character] = []
    
    var roles: [String] = []
    var results: [Player] = []
    let columns: [GridItem] = [
        GridItem(.adaptive(minimum: UIScreen.main.bounds.width / 3, maximum: 700))
    ]
    
    init() {
        totalCharacters = 0
        baseCharacters = startBase
        moreCharacters = startMore
        favoritesCharacters = restFavorite
    }
    
    // MARK: PRIVATE FUNCTIONS
    
    private func getRoles() {
        if game == .favorites {
            for character in favoritesCharacters {
                roles.append(
                    contentsOf: repeatElement(character.name, count: character.count)
                )
            }
        } else {
            for character in game == .base ? baseCharacters : moreCharacters {
                roles.append(
                    contentsOf: repeatElement(character.name, count: character.count)
                )
            }
        }
        
        roles.shuffle()
    }
    
    private func getResults() {
        for index in 0..<roles.count {
            results.append(Player(name: playersForGame[index],
                                  role: roles[index]))
        }
    }
    
    // MARK: FUNCTIONS
    
    func add(_ character: Character) {
        favoritesCharacters.append(character)
    }
    
    func delete(_ character: Character) {
        if let index = favoritesCharacters.firstIndex(where: { $0.name == character.name }) {
            favoritesCharacters.remove(at: index)
        }
    }
    
    func refreshTotalCharacters() {
        var count = 0
        for character in game == .base
                ? baseCharacters
                : game == .favorites
                ? favoritesCharacters
                : moreCharacters {
            count += character.count
        }
        totalCharacters = count
    }
    
    func next() {
        playersForGame.removeAll()
        for player in players {
            if !player.isEmpty {
                playersForGame.append(player)
            }
        }
        
        if playersForGame.count > 0 {
            if players[0] == "Мафия" || players[0] == "Mafia" {
                isShowingEgg.toggle()
            } else {
                HapticManager.instance.impact(style: .soft)
                section = .characters
            }
        } else {
            showAlert()
            HapticManager.instance.notification(type: .warning)
        }
    }
    
    func showAlert() {
        isShowingAlert = true
    }
    
    func start() {
        if canGameStart() {
            roles.removeAll()
            results.removeAll()
            getRoles()
            getResults()
            isStartView.toggle()
        }
    }
    
    func back() {
        section = .players
    }
    
    func showSupportView() {
        isShowingSupportView.toggle()
    }
    
    /// Checks if the game can start
    ///
    /// This function checks if the players count equal to characters count
    /// ```
    /// canGameStart() -> true
    ///
    /// ```
    func canGameStart() -> Bool {
        totalCharacters == playersForGame.count
    }
    
    /// Rest characters
    ///
    /// This function rests baseCharacters and moreCharacters back to start
    /// ```
    /// restCharacters()
    ///
    /// ```
    func restCharacters() {
        baseCharacters = startBase
        moreCharacters = startMore
        favoritesCharacters = restFavorite
        totalCharacters = 0
        HapticManager.instance.impact(style: .light)
    }
    
}
