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
    @StateObject var habitModel = HabitViewModel()
    @ObservedObject var postModel = PostViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    LazyVStack {
                        if (habitModel.list.isEmpty) {
                            Text("Create your first habit!")
                                .foregroundColor(.gray)
                                .padding(.top, 300)
                        } else {
                            ForEach(Array(habitModel.list.enumerated()), id: \.1) { index, habit in
                                DisclosureGroup(isExpanded: $revealDetails[index]) {
                                    HabitExpand(description: habit.description,
                                                habitID: habit.id ?? "",
                                                habitColor: .red,
                                                postModel: postModel,
                                                habitModel: habitModel)
                                } label: {
                                    HabitCard(habit: habit, habitColor: Color.red)
                                        .padding(.leading, 20)
                                }
                                .buttonStyle(PlainButtonStyle()).accentColor(.clear)
                                .onTapGesture {
                                    self.lastClickedHabit = index
                                }
                            }
                            .onReceive(postModel.$didUploadPost) { success in
                                if success {
                                    revealDetails[lastClickedHabit] = false
                                }
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

