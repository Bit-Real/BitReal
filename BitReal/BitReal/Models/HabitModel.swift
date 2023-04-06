//
//  HabitModel.swift
//  BitReal
//
//  Created by Don Nguyen on 3/23/23.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase

struct HabitModel: Identifiable, Hashable, Decodable {
    @DocumentID var id: String?
    var uid: String
    var name: String
    var description: String
    var frequency: Int
    var alarm: Date
    var privacy: Bool
    var streak: Int
    var progress: [Bool]
    let timestamp: Timestamp
    var nextSundayDate: Timestamp
    var lastUpdate: Timestamp
    var skipDays: Int
}


