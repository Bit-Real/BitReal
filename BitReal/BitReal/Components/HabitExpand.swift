//
//  HabitExpand.swift
//  BitReal
//
//  Created by Pinru Chen on 3/30/23.
//

import SwiftUI

struct HabitExpand: View {
    
    @State private var text = ""
    private let placeholder = "Post your habit!"
    var description: String
    var habitID: String
    var habitColor: Color
    @ObservedObject var postModel: PostViewModel
    @ObservedObject var habitModel: HabitViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text(description)
                    .font(.system(size: 15))
                    .padding()
                Spacer()
            }
            HStack {
                TextEditor(text: self.$text)
                    .frame(height: 100)
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding([.horizontal], 4)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray))
                    .padding([.horizontal], 16)
            }
            HStack {
                ZStack {
                    Color("cardGray")
                    HStack {                        
                        Button {
                            // upload post only if textfield is not empty
                            if (!text.isEmpty) {
                                postModel.uploadPost(withCaption: text)
                            }
                            let dayOfweek = getCurrentDayOfWeek()
                            habitModel.updateHabitProgress(habitID: habitID, dayIndex: dayOfweek, completed: true)
                        } label: {
                            Image(systemName: text.isEmpty ? "checkmark.circle" : "paperplane")
                                .foregroundColor(habitColor)
                            Text(text.isEmpty ? "Mark Done" : "Mark & Post")
                                .fontWeight(.medium)
                        }
                        .foregroundColor(habitColor)
                        .padding(.leading, -5)
                    }
                }
            }
            .cornerRadius(10, corners: [.bottomLeft, .bottomRight])
        }
        .frame(width: 350, height: 225)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 1)
        )
    }
}

func getCurrentDayOfWeek() -> Int {
    let calendar = Calendar.current
    let today = Date()
    let weekday = calendar.component(.weekday, from: today)
    print("Day is: \(weekday - 1)")
    return weekday - 1
}

// Used to specify which corner to round
struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

