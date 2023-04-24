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

// contains useful utility functions used throughout the project
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
    
    // returns the day of the week, zero-indexed
    static func getCurrentDayOfWeek() -> Int {
        let calendar = Calendar.current
        let today = Date()
        let weekday = calendar.component(.weekday, from: today)
        return weekday - 1
    }
    
    // given a String, returns a Bool to indicate if the string is in an email format or not
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }

}
