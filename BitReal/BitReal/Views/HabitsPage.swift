//
//  HabitsPage.swift
//  BitReal
//
//  Created by Ali Al-Adhami on 2/23/23.
//

import SwiftUI
import Firebase

struct HabitsPage: View {
    
    @ObservedObject var model = HabitViewModel()
    
    init() {
        model.getData()
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    LazyVStack {
                        ForEach(model.list) { habit in
                            DisclosureGroup {
                                HabitExpand(description: habit.description, habitColor: .red)
                            } label: {
                                HabitCard(habitName: habit.name, habitColor: Color.red)
                                    .padding(.leading, 20)
                            }
                            .buttonStyle(PlainButtonStyle()).accentColor(.clear)
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

