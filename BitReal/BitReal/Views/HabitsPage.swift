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
                                                habitColor: Color(hex: habit.habitColor),
                                                postModel: postModel,
                                                habitModel: habitModel)
                                } label: {
                                    HabitCard(habit: habit, habitColor: Color(hex: habit.habitColor))
                                        .padding(.leading, 20)
                                }
                                .buttonStyle(PlainButtonStyle()).accentColor(.clear)
                                .onTapGesture {
                                    self.lastClickedHabit = index
                                }
                                .contextMenu {
                                    Button(action: {
                                        // Mark a habit undone
                                        habitModel.undoHabit(habitID: habit.id ?? "")
                                    }) {
                                        Label("Mark Undone", systemImage: "minus.circle")
                                    }
                                    
                                    Button(action: {
                                        // Delete habit action
                                    }) {
                                        Label("Delete Habit", systemImage: "trash")
                                    }
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

// extension to allow Color to accept a String hex value for colors
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

struct HabitsPage_Previews: PreviewProvider {
    static var previews: some View {
        HabitsPage()
    }
}

