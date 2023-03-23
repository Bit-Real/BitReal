//
//  UserService.swift
//  BitReal
//
//  Created by Ali Al-Adhami on 3/22/23.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct UserService {
    func fetchUser(withUID uid: String, completion: @escaping(User) -> Void) {
        Firestore.firestore().collection("users")
            .document(uid)
            .getDocument { snapshot, _ in
                guard let snapshot = snapshot else { return }
                guard let user = try? snapshot.data(as: User.self) else { return }
                completion(user)
            }
    }
}

