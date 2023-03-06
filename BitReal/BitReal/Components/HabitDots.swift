//
//  HabitDots.swift
//  BitReal
//
//  Created by Ali Al-Adhami on 3/4/23.
//

import SwiftUI

struct HabitDots: View {
    
    var color: Color
    var fill: Bool
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(color, lineWidth: 1)
                .background(fill ? Circle().foregroundColor(color) : Circle().foregroundColor(.white))
        }
        .frame(width: 12, height: 12)
    }
}

struct HabitDots_Previews: PreviewProvider {
    static var previews: some View {
        HabitDots(color: .red, fill: false)
    }
}
