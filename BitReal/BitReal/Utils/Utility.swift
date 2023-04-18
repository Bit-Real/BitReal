//
//  Utility.swift
//  BitReal
//
//  Created by Ali Al-Adhami on 4/11/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import UIKit
import SwiftUI

class Utility {
    
    // given a Timestamp, returns how long since it's been created
    static func convertTimestampToString(timestamp: Timestamp) -> String {
        let now = Date()
        let dateFromTimestamp = timestamp.dateValue()
        
        let timeInterval = now.timeIntervalSince(dateFromTimestamp)
        
        let secondsInMinute: TimeInterval = 60
        let secondsInHour: TimeInterval = 3600
        let secondsInDay: TimeInterval = 86400
        
        if timeInterval >= secondsInDay {
            let days = Int(timeInterval / secondsInDay)
            return "\(days)d"
        } else if timeInterval >= secondsInHour {
            let hours = Int(timeInterval / secondsInHour)
            return "\(hours)h"
        } else if timeInterval >= secondsInMinute {
            let minutes = Int(timeInterval / secondsInMinute)
            return "\(minutes)m"
        } else {
            let seconds = Int(timeInterval)
            return "\(seconds)s"
        }
    }

    // given a String, truncate it if longer than maxLength
    static func truncateString(_ input: String, maxLength: Int = 15) -> String {
        if input.count > maxLength {
            let truncated = input.prefix(maxLength)
            return "\(truncated)..."
        }
        return input
    }
    
    static func getCurrentDayOfWeek() -> Int {
        let calendar = Calendar.current
        let today = Date()
        let weekday = calendar.component(.weekday, from: today)
        print("Day is: \(weekday - 1)")
        return weekday - 1
    }

}
