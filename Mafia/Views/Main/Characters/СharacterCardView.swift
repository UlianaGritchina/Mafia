import SwiftUI

struct CharacterCardView: View {
    @Binding var character: Character
    @Binding var totalCount: Int
    private let width = UIScreen.main.bounds.width
    private let height = UIScreen.main.bounds.height
    var body: some View {
        ZStack {
            characterView.onTapGesture { addDon() }
        }
    }
    
    func addDon() {
        if character.name == "Дон" || character.name == "Ведущий" {
            if character.count == 0 {
                character.count = 1
                totalCount += 1
                HapticManager.instance.impact(style: .light)
            } else {
                totalCount -= 1
                character.count = 0
            }
        }
    }
    
    func minusCharacter() {
        if character.count != 0 {
            character.count -= 1
            totalCount -= 1
            HapticManager.instance.impact(style: .light)
        }
    }
    
    func plusCharacter() {
        character.count += 1
        totalCount += 1
        HapticManager.instance.impact(style: .light)
    }
    
}

struct CharacterCardView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterCardView(
            character: .constant(Character(name: "name", count: 1)),
            totalCount: .constant(0)
        )
    }
}

extension CharacterCardView {
    
    var characterView: some View {
        characterCard.overlay(characterContent)
    }
    
    var characterContent: some View {
        VStack {
            if character.name != "Добавить" {
                characterName
                if character.name != "Дон" && character.name != "Ведущий" {
                    Spacer()
                    HStack {
                        CharacterCountButtonView(sign: "-") { minusCharacter() }
                        Spacer()
                        characterCount
                        Spacer()
                        CharacterCountButtonView(sign: "+") { plusCharacter() }
                    }
                }
            }
        }
        .padding()
    }
    
    var characterName: some View {
        Text(character.name)
            .foregroundColor(.white)
            .bold()
            .font(.system(size: height / 40))
    }
    
    var characterCount: some View {
        Text("\(character.count)")
            .foregroundColor(.white)
            .bold()
            .font(.system(size: height / 40))
    }
    
    var characterCard: some View {
        RoundedRectangle(cornerRadius: 20)
            .frame(width: width / 2.4,
                   height: height / 5)
            .foregroundColor(.black)
            .shadow(
                color: character.count != 0
                ? .red.opacity(0.8)
                : .white.opacity(0.4),
                radius: 5, x: 0, y: 0
            )
    }
    
}

