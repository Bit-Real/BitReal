//
//  HabitsPage.swift
//  BitReal
//
//  Created by Ali Al-Adhami on 2/23/23.
//

import SwiftUI
import Firebase

struct HabitsPage: View {
    
    @State private var revealDetails: [Bool] = Array(repeating: false, count: 1000)
    @State private var lastClickedHabit = 0
    @ObservedObject var model = HabitViewModel()
    @ObservedObject var viewModel = PostViewModel()
    
    init() {
        model.getData()
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    LazyVStack {
                        ForEach(Array(model.list.enumerated()), id: \.1) { index, habit in
                            DisclosureGroup(isExpanded: $revealDetails[index]) {
                                HabitExpand(description: habit.description,
                                            habitColor: .red,
                                            viewModel: viewModel)
                            } label: {
                                HabitCard(habitName: habit.name, habitColor: Color.red)
                                    .padding(.leading, 20)
                            }
                            .buttonStyle(PlainButtonStyle()).accentColor(.clear)
                            .onTapGesture {
                                self.lastClickedHabit = index
                            }
                        }
                        .onReceive(viewModel.$didUploadPost) { success in
                            if success {
                                revealDetails[lastClickedHabit] = false
                            }
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

