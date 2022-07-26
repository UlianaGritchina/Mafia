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
    @Published var selectedBaseCharacters: [Character] = []
    @Published var selectedMoreCharacters: [Character] = []
    @Published var eggsCount = 0
    @Published var isShowingFinalEggsView = false
    @Published var favoritesCharacters: [Character] = [] {
        didSet { saveCharacters() }
    }
    
    let favoriteKey = "favorite"
    
    let transition: AnyTransition = .asymmetric(
        insertion: .move(edge: .trailing),
        removal: .move(edge: .leading)
    )
    
    let transition2: AnyTransition = .asymmetric(
        insertion: .move(edge: .leading),
        removal: .move(edge: .trailing)
    )
    
    let columns: [GridItem] = [
        GridItem(.adaptive(minimum: UIScreen.main.bounds.width / 3, maximum: 700))
    ]
    
    var startBase: [Character] = GameDataManager.instance.startBaseCharacters
    var startMore: [Character] = GameDataManager.instance.startMoreCharacters
    var roles: [String] = []
    var results: [Player] = []
    
    init() {
        selectedBaseCharacters = startBase
        selectedMoreCharacters = startMore
        getCharacters()
    }
    
    // MARK: PRIVATE FUNCTIONS
    
    private func getRoles() {
        for character in getCharactersForGame() {
            roles.append(
                contentsOf: repeatElement(character.name, count: character.count)
            )
        }
        roles.shuffle()
    }
    
    private func getCharactersForGame() -> [Character] {
        switch game {
        case .base:
            return selectedBaseCharacters
        case .more:
            return selectedMoreCharacters
        case .favorites:
            return favoritesCharacters
        }
    }
    
    private func getPlayersForGame() {
        for player in players {
            if !player.isEmpty {
                playersForGame.append(player)
            }
        }
    }
    
    private func getResults() {
        for index in 0..<roles.count {
            results.append(Player(name: playersForGame[index],
                                  role: roles[index]))
        }
    }
    
    // MARK: FUNCTIONS
    
    func showFinalEggsView() {
        if eggsCount == 3 {
            isShowingFinalEggsView = true
        } else {
            HapticManager.instance.notification(type: .error)
        }
    }
    
    func isShowingNoFavoritesView() -> Bool {
        game == .favorites && favoritesCharacters.isEmpty
    }
    
    
    func getCharacters() {
        guard
            let data = UserDefaults.standard.data(forKey: favoriteKey),
            let savedCharacters = try? JSONDecoder().decode([Character].self, from: data)
        else { return }
        
        favoritesCharacters = savedCharacters
    }
    
    func add(_ character: Character) {
        let newCharacter = Character(name: character.name, count: 0)
        favoritesCharacters.append(newCharacter)
    }
    
    func delete(_ character: Character) {
        if let index = favoritesCharacters.firstIndex(where: { $0.name == character.name }) {
            favoritesCharacters.remove(at: index)
        }
    }
    
    func saveCharacters() {
        if let encodedData = try? JSONEncoder().encode(favoritesCharacters) {
            UserDefaults.standard.set(encodedData, forKey: favoriteKey)
        }
    }
    
    func refreshTotalCharacters() {
        var count = 0
        for character in getCharactersForGame() {
            count += character.count
        }
        totalCharacters = count
    }
    
    func next() {
        playersForGame.removeAll()
        getPlayersForGame()
        if playersForGame.count > 0 {
            if players[0] == "Мафия" || players[0] == "Mafia" {
                isShowingEgg.toggle()
            } else {
                section = .characters
            }
        } else {
            showAlert()
            HapticManager.instance.notification(type: .warning)
        }
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
    
    func showAlert() { isShowingAlert = true }
    
    func showSupportView() { isShowingSupportView.toggle() }
    
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
    
}
