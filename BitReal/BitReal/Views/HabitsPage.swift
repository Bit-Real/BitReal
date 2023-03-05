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
                ScrollView {
                    LazyVStack {
                        ForEach(habits, id: \.id) { habit in
                            HabitCard(habitName: habit.name, habitColor: habit.color)
                        }
                    }
                }
                VStack {
                    Spacer()
                    NavigationLink(destination: CreateHabitPage()) {
                        AddButton()
                    }
                    .padding(.trailing, 10)
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

