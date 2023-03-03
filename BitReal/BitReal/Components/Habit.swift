//
//  Habit.swift
//  BitReal
//
//  Created by Don Nguyen on 3/1/23.
//

import SwiftUI

class Habit: Identifiable {
    let id = UUID()
    var name: String
    var streak: Int
    var totalCount: Int
    
    init(name: String) {
        self.name = name
        self.streak = 0
        self.totalCount = 0
    }
    
    func logHabit() {
        self.totalCount += 1
    }
    
    // streaks need another mechanism to properly track.
    // Not sure if a timer is the right way to go about it. 
}

struct HabitList {
    static let habits = [Habit(name: "Walk a milke"), Habit(name: "Eat an Apple"), Habit(name: "Read a book")]
    
}
