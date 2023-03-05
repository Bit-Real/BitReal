//
//  HabitsPage.swift
//  BitReal
//
//  Created by Ali Al-Adhami on 2/23/23.
//

import SwiftUI

struct HabitsPage: View {
    
    var habits: [Habit] = HabitList.habits
    
    var body: some View {
        NavigationView {
            ZStack {
//                List(habits, id: \.id) { habit in
//                    VStack {
//                        Text(habit.name)
//                    }
//                }
                ScrollView {
                    LazyVStack {
                        ForEach(habits, id: \.id) { habit in
                            HabitCard(habitName: habit.name, dotsColor: habit.color)
                        }
                    }
                }
                VStack {
                    Spacer()
                    NavigationLink(destination: CreateHabitPage()) {
                        AddButton()
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding()
                }
                .navigationTitle("Your Habits")
            }
            
        }
        .navigationBarBackButtonHidden()
    }
}

struct HabitsPage_Previews: PreviewProvider {
    static var previews: some View {
        HabitsPage()
    }
}

