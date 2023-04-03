//
//  HabitCard.swift
//  BitReal
//
//  Created by Ali Al-Adhami on 3/4/23.
//

import SwiftUI

struct HabitCard: View {
    
    @State var habit: HabitModel
    var habitColor: Color
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(habitColor)
                .frame(width: 350, height: 50)
                .offset(x: -5)
            HStack {
                Text(habit.name)
                    .font(.system(size: 18))
                    .padding()
                Spacer()
                HStack {
                    HabitDots(color: habitColor, fill: habit.progress[0])
                    HabitDots(color: habitColor, fill: habit.progress[1])
                    HabitDots(color: habitColor, fill: habit.progress[2])
                    HabitDots(color: habitColor, fill: habit.progress[3])
                    HabitDots(color: habitColor, fill: habit.progress[4])
                    HabitDots(color: habitColor, fill: habit.progress[5])
                    HabitDots(color: habitColor, fill: habit.progress[6])
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

//struct HabitCard_Previews: PreviewProvider {
//    static var previews: some View {
//        HabitCard(habitName: "Run 4 Miles", habitColor: .green)
//    }
//}
