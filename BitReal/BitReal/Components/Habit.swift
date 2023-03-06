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
    var description: String
    var streak: Int
    var totalCount: Int
    var color: Color = Color.purple
    
    init(name: String, description: String, color: Color) {
        self.name = name
        self.description = description
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
    static let habits = [Habit(name: "Walk a mile",
                               description:"Complete my daily one mile walk",
                               color: Color.red),
                         Habit(name: "Eat an Apple",
                               description:"One apple a day keeps the doctor away!",
                               color: Color.green),
                         Habit(name: "Read a book",
                               description: "Reading The Millionaire Next Door: The Surprising Secrets of America's Wealthy",
                               color: Color.yellow)]
    
}
