import SwiftUI

struct CharactersGridView: View {
    @Binding var characters: [Character]
    @Binding var totalCharacters: Int
    var body: some View {
        ForEach($characters, id: \.self) { character in
            CharacterCardView(character: character,
                              totalCount: $totalCharacters)
                .padding()
                .contextMenu {
                    Button(action: {}) {
                        Text("Добавить в Избранные")
                    }
                }
        }
    }
}

struct CharactersGridView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersGridView(
            characters: .constant(
                [Character(name:  "name",count: 5),]),
                totalCharacters: .constant(5))
    }
}
