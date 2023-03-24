//
//  User.swift
//  BitReal
//
//  Created by Ali Al-Adhami on 3/22/23.
//

import FirebaseFirestoreSwift

struct User: Identifiable, Decodable, Hashable {
    // fields name should match what is on Firestore
    @DocumentID var id: String?
    let email: String
    let username: String
    let fullname: String
    let friends: [String]
    let profileImageURL: String
    
    // to keep track if currentUser is friend with this user
    var isFriend: Bool? = false
}
