//
//  NotificationModel.swift
//  BitReal
//
//  Created by Don Nguyen on 4/14/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct NotificationModel: Identifiable, Decodable, Hashable {
    @DocumentID var id: String?
    let userID: String
    let friendUserID: String    // Applicable for "Follow", "Like", "Comment"
    let type: String            // "Follow", "Comment", "Like", "Habit"
    let postID: String          // Applicable for "Comment" or "Like"
    let habitID: String         // Applicable for "Habit"
    var alarm: Date             // Determines when to send the notification
    let timestamp: Date         // Shows the time when notification is received. Not sure if needed if we already have alarm.
    var content: String         // What the notification actually contains
    
}
