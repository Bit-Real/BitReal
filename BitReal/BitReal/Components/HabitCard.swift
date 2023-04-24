//
//  HabitCard.swift
//  BitReal
//
//  Created by Ali Al-Adhami on 3/4/23.
//

import SwiftUI
import Firebase

struct HabitCard: View {
    
    @State var habit: HabitModel
    var habitColor: Color
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(habitColor)
                .frame(width: 350, height: 60)
                .offset(x: -5)
            
            HStack {
                VStack(alignment: .leading) {
                    Text(Utility.truncateString(habit.name, maxLength: 18))
                        .font(.system(size: 16))
                        .padding(.leading, 15)
                    HStack(spacing: 2) {
                        Text("Last update")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                            .padding(.leading, 15)
                        Text("•")
                                .font(.system(size: 15))
                                .foregroundColor(.gray)
                        Text(Utility.convertTimestampToString(timestamp: habit.lastUpdate))
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                        
                        // only display streak count if it's over 5
                        // to reduce spatial clutter
                        if (habit.streak > 5) {
                            Text("•")
                                    .font(.system(size: 15))
                                    .foregroundColor(.gray)
                            Text("\(habit.streak)")
                                .font(.system(size: 14))
                            Image(systemName: "flame")
                                .foregroundColor(.red)
                        }
                    }
                }
                
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
            .frame(width: 350, height: 64)
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 1)
                )
        }
    }
}
