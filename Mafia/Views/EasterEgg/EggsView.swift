import SwiftUI
import SpriteKit

// MARK: MAIN VIEW
struct EggsView: View {
    @StateObject var vm = EggsViewViewModel()
    var body: some View {
        ZStack {
            SceneView(scene: vm.eggsRain)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EggsView()
    }
}

// MARK: MAIN VIEW VIEW MODEL
enum GameTapy {
    case bigEggs
    case eggsRain
}

class EggsViewViewModel: ObservableObject {
    
    var eggsRain: SKScene {
        let scene = EggsRainScene()
        scene.size = CGSize(width: UIScreen.main.bounds.width, height: 600)
        scene.scaleMode = .fill
        return scene
    }
    
    @Published var eggs = 0
    @Published var isShowingSettings = false
    @Published var mainScene: GameTapy = .eggsRain
    
    init() {
        chooseScene(game: .eggsRain)
    }
    
    func addEgg() {
        eggs += 1
    }
    
    func toglleIsShowingSettings() {
        isShowingSettings.toggle()
    }
    
    func chooseScene(game: GameTapy) {
        eggs = 0
        switch game {
        case .bigEggs: mainScene = .bigEggs
        case .eggsRain: mainScene = .eggsRain
        }
    }
    
}

// MARK: EGGS COUNTER VIEW
struct EggsCounterView: View {
    @Binding var eggs: Int
    let action: () -> ()
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    var body: some View {
        VStack {
            Button(action: {action()}) {
                Text("\(eggs)")
                    .bold()
                    .foregroundColor(.white)
                    .font(.system(size: height / 25))
                    .frame(width: width / 2, height: height / 16)
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
            }
            Spacer()
        }
        .padding(.top, height / 25)
    }
}

// MARK: SCENE VIEW
struct SceneView: View {
    let scene: SKScene
    var body: some View {
        SpriteView(scene: scene)
            .frame(width: UIScreen.main.bounds.width,
                   height: UIScreen.main.bounds.height)
            .ignoresSafeArea()
    }
}

// MARK: SETTINGS VIEW
struct SettingsView: View {
    let vm: EggsViewViewModel
    @Binding var mainScene: GameTapy
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    var body: some View {
        Rectangle()
            .frame(width: width / 1.5, height: height / 4)
            .opacity(0.5)
            .background(.ultraThinMaterial)
            .cornerRadius(20)
            .overlay(
                VStack {
                    
                    Button(action: {
                        vm.chooseScene(game: .eggsRain)
                        vm.toglleIsShowingSettings()
                    }) {
                        Text("Eggs Rain")
                            .bold()
                            .foregroundColor(.white)
                            .font(.system(size: height / 35))
                            .opacity(mainScene == .eggsRain ? 1 : 0.5)
                    }
                    .padding()
                    
                    Button(action: {
                        vm.chooseScene(game: .bigEggs)
                        vm.toglleIsShowingSettings()
                    }) {
                        Text("Big Eggs")
                            .bold()
                            .foregroundColor(.white)
                            .font(.system(size: height / 35))
                            .opacity(mainScene == .bigEggs ? 1 : 0.5)
                    }
                    
                }
                    .padding()
            )
    }
}

// MARK: EGGS RAIN VIEW
class EggsRainScene: SKScene {
    var egg = SKSpriteNode(imageNamed: "egg\(Int.random(in: 1...5))")
    
    override func didMove(to view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "mrRobot2")
        background.scale(to: CGSize(width: 450,
                                    height: 600))
        background.position = CGPoint(x: 210, y: 300)
        background.zPosition = -1
        background.alpha = 0.7
        
        addChild(background)
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        egg = SKSpriteNode(imageNamed: "egg\(Int.random(in: 1...5))")
        egg.position = location
        egg.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 20, height: 40))
        egg.size = CGSize(width: 60, height: 40)
        addChild(egg)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            egg = SKSpriteNode(imageNamed: "egg\(Int.random(in: 1...5))")
            egg.position = location
            egg.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 20, height: 40))
            egg.size = CGSize(width: 60, height: 40)
            egg.position.x = location.x
            egg.position.y = location.y
            addChild(egg)
        }
    }
    
}
