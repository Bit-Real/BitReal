//
//  Habit.swift
//  BitReal
//
//  Created by Don Nguyen on 3/1/23.
//
// DEPRECATED

import SwiftUI

// used for internal testing
class Habit: Identifiable {
    let id = UUID()
    var name: String
    var streak: Int
    var totalCount: Int
    var color: Color = Color.purple
    
    init(name: String, color: Color) {
        self.name = name
        self.streak = 0
        self.totalCount = 0
        self.color = color
    }
    
    func logHabit() {
        self.totalCount += 1
    }
    
    // streaks need another mechanism to properly track.
    // Not sure if a timer is the right way to go about it. 
}

struct HabitList {
    static let habits = [Habit(name: "Walk a mile", color: Color.red),
                         Habit(name: "Eat an Apple", color: Color.green),
                         Habit(name: "Read a book", color: Color.yellow)]
    
}
