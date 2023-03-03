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
                List(habits, id: \.id) { habit in
                    VStack {
                        Text(habit.name)
                    }
                }
                VStack {
                    Spacer()
                    NavigationLink(destination: CreateHabitPage()) {
                        Image(systemName: "plus")
                            .padding()
                            .background(Color.white)
                            .foregroundColor(Color.purple)
                            .clipShape(Circle())
                            .shadow(radius: 8)
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

