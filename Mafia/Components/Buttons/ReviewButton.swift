import SwiftUI

struct ReviewButton: View {
    private let width = UIScreen.main.bounds.width
    private let height = UIScreen.main.bounds.height
    var body: some View {
        VStack {
            HStack {
                Link(destination: URL(string: "https://apps.apple.com/ru/app/mafia-gang/id1638964730")!) {
                    Text("Написать отзыв")
                        .bold()
                        .font(.system(size: height / 50))
                        .foregroundColor(.white)
                        .frame(width: width / 2.5, height: height / 20)
                        .background(Capsule().stroke())
                }
                .padding(.horizontal)
                
                Link(destination: URL(string: "https://apps.apple.com/ru/app/mafia-gang/id1638964730")!) {
                    Text("Оценить")
                        .bold()
                        .font(.system(size: height / 50))
                        .foregroundColor(.white)
                        .frame(width: width / 2.5, height: height / 20)
                        .background(Capsule().stroke(.green))
                }
                .padding(.horizontal)
            }.padding()
            
            Link(destination: URL(string: "https://www.tinkoff.ru/cf/1yvFPYgx2ff")!) {
                Text("Tinkoff")
                    .bold()
                    .foregroundColor(.white)
                    .font(.system(size: height / 45))
                    .frame(width: width / 1.5, height: height / 20)
                    .background(Capsule().stroke(.yellow))
            }
            
            Text("Сделайте приложение лучше")
                .font(.headline)
                .padding()
        }
    }
}


struct ReviewButton_Previews: PreviewProvider {
    static var previews: some View {
        ReviewButton()
    }
}

struct StarButton: View {
    private let width = UIScreen.main.bounds.width
    private let height = UIScreen.main.bounds.height
    var body: some View {
        Button(action: {}) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: width / 2.5, height: 50)
                    .foregroundColor(Color("star"))
                
                Link(destination: URL(string: "https://apps.apple.com/ru/app/mafia-gang/id1638964730")!) {
                    Text("Оценить")
                        .bold()
                        .font(.system(size: height / 45))
                        .foregroundColor(.white)
                        .frame(width: width / 2.5, height: height / 20)
                }
            }
        }
    }
}
