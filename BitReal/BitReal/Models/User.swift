//
//  User.swift
//  BitReal
//
//  Created by Ali Al-Adhami on 3/22/23.
//

import FirebaseFirestoreSwift

struct User: Identifiable, Decodable {
    // fields name should match what is on Firestore
    @DocumentID var id: String?
    let email: String
    let username: String
    let fullname: String
    let profileImageURL: String
}
