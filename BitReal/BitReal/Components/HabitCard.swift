//
//  HabitCard.swift
//  BitReal
//
//  Created by Ali Al-Adhami on 3/4/23.
//

import SwiftUI

struct HabitCard: View {
    
    var habitName: String
    var dotsColor: Color
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(dotsColor)
                .frame(width: 350, height: 50)
                .offset(x: -5)
            HStack {
                Text(habitName)
                    .font(.system(size: 18))
                    .padding()
                Spacer()
                HStack {
                    HabitDots(color: dotsColor, fill: true)
                    HabitDots(color: dotsColor, fill: true)
                    HabitDots(color: dotsColor, fill: true)
                    HabitDots(color: dotsColor, fill: false)
                    HabitDots(color: dotsColor, fill: false)
                    HabitDots(color: dotsColor, fill: false)
                    HabitDots(color: dotsColor, fill: true)
                }
                .padding()
            }
            .frame(width: 350, height: 54)
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 1)
                )
        }
    }
}

struct HabitCard_Previews: PreviewProvider {
    static var previews: some View {
        HabitCard(habitName: "Run 4 Miles", dotsColor: .green)
    }
}
