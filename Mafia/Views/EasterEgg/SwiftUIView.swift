//
//  SwiftUIView.swift
//  Mafia
//
//  Created by Ульяна Гритчина on 06.09.2022.
//

import SwiftUI

class AA: ObservableObject {
    @Published var s = 1.0
}

struct SwiftUIView: View {
    @StateObject var vm = AA()
    var body: some View {
        ProgressView(value: vm.s, total: 0.0)
            .progressViewStyle(.linear)
            .onAppear {
                vm.s = 0.0
            }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
