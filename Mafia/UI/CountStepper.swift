//
//  CountStepper.swift
//  Mafia
//
//  Created by Ульяна Гритчина on 09.02.2024.
//

import SwiftUI

struct CountStepper: View {
    
    @Binding var count: Int
 
    let range: ClosedRange<Int>?
    
    init(count: Binding<Int>, range: ClosedRange<Int>? = nil) {
        _count = count
        self.range = range
    }
    
    var minusButtunDisabled: Bool {
        guard let range else { return false }
        return count <= range.lowerBound
    }
    
    var plusButtunDisabled: Bool {
        guard let range else { return false }
        return count >= range.upperBound
    }
    
    var body: some View {
        HStack {
            Button(action: { count -= 1 }, label: {
                Image(systemName: "minus")
                    .frame(width: 30, height: 30)
            })
            .disabled(minusButtunDisabled)
            
            Divider()
                .padding(.vertical, 3)
            
            Spacer()
            
            Text(count.description)
                .font(.title3)
            
            Spacer()
            
            Divider()
                .padding(.vertical, 3)
            
            Button(action: { count += 1 }, label: {
                Image(systemName: "plus")
                    .frame(width: 30, height: 30)
            })
            .disabled(plusButtunDisabled)
            
        }
        .padding(.horizontal, 5)
        .background(.ultraThinMaterial)
        .cornerRadius(5)
    }
}

#Preview {
    CountStepper(count: .constant(5))
}
