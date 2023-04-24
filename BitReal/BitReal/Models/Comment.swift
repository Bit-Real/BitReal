//
//  Comment.swift
//  BitReal
//
//  Created by Ali Al-Adhami on 4/6/23.
//

import SwiftUI
import FirebaseFirestoreSwift
import Firebase

struct Comment: Identifiable, Codable {
    @DocumentID var id: String?
    var userId: String
    var text: String
    var timestamp: Timestamp
    var postId: String?
    var userName: String?
    var userProfilePicUrl: String?
}
