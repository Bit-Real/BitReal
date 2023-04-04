//
//  HabitModel.swift
//  BitReal
//
//  Created by Don Nguyen on 3/23/23.
//

import Foundation

struct HabitModel: Identifiable {
    
    var id: String
    var uid: String
    var name: String
    var description: String
    var frequency: Int
    var alarm: Date
    var privacy: Bool
    var streak: Int
}


