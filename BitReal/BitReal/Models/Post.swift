//
//  Post.swift
//  BitReal
//
//  Created by Ali Al-Adhami on 3/31/23.
//

import FirebaseFirestoreSwift
import Firebase

struct Post: Identifiable, Decodable, Hashable {
    @DocumentID var id: String?
    let caption: String
    let timestamp: Timestamp
    let uid: String
    var likes: Int
    var user: User?
}
