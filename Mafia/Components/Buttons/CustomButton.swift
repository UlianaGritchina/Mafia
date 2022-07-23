//
//  CustomButton.swift
//  CacheImagesInSwiftUI
//
//  Created by Ульяна Гритчина on 11.07.2022.
//

import SwiftUI

struct CustomButton: View {
    let tile: String
    let color: Color
    let action: () -> ()
    var width: CGFloat
    let height: CGFloat
    
    init(title: String,
         color: Color,
         action: @escaping () -> (),
         width: CGFloat? = nil,
         height: CGFloat? = nil) {
        
        self.tile = title
        self.color = color
        self.action = action
        
        if let width = width {
            self.width = width
        } else {
            self.width = UIScreen.main.bounds.width / 2.5
        }
        
        if let height = height {
            self.height = height
        } else {
            self.height = UIScreen.main.bounds.height / 20
        }
        
    }
    
    var body: some View {
        Button(action: action) {
            Text(tile)
                .foregroundColor(.white)
                .bold()
                .frame(width: width,height: height)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(color)
                )
        }
    }
    
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(title: "title", color: .blue, action: {})
    }
}

