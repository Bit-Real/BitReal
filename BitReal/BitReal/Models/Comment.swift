//
//  Comment.swift
//  BitReal
//
//  Created by Ali Al-Adhami on 4/6/23.
//

import FirebaseFirestoreSwift
import Firebase

struct Comment: Identifiable, Codable {
    @DocumentID var id: String?
    let text: String
    let timestamp: Date
    let userId: String
}
