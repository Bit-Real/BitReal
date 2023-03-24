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
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    func fetchUser(withUID uid: String, completion: @escaping(User) -> Void) {
        Firestore.firestore().collection("users")
            .document(uid)
            .getDocument { snapshot, _ in
                guard let snapshot = snapshot else { return }
                guard let user = try? snapshot.data(as: User.self) else { return }
                completion(user)
            }
    }
    
    func fetchAllUsers(completion: @escaping([User]) -> Void) {
        var users = [User]()
        Firestore.firestore().collection("users").getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            documents.forEach { document in
                guard let user = try? document.data(as: User.self) else { return }
                users.append(user)
            }
            completion(users)
        }
    }
    
    // adds friendUID to currentUser friend collection
    func beFriends(_ friendUser: User, completion: @escaping() -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let friendUID = friendUser.id else { return }
        
        let userFriendRef = Firestore.firestore().collection("users").document(uid).collection("friends")
        userFriendRef.document(friendUID).setData([:]) { _ in
            print("DEBUG: Added \(friendUID) as a friend to \(uid)")
            completion()
        }
    }
    
    // check if this user is friends with currentUser
    func isFriends(_ friendUser: User, completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let friendUID = friendUser.id else { return }
        Firestore.firestore().collection("users").document(uid).collection("friends").document(friendUID)
            .getDocument { snapshot, _ in
                if let snapshot = snapshot, snapshot.exists {
                    completion(true)
                } else {
                    completion(false)
                }
            }
    }
    
    func unfriend(_ friendUser: User, completion: @escaping() -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let friendUID = friendUser.id else { return }
        Firestore.firestore().collection("users").document(uid).collection("friends")
            .document(friendUID).delete() { error in
                if let error = error {
                    print("ERROR: failed to remove friend, \(error.localizedDescription)")
                    completion()
                } else {
                    completion()
                    print("Unfriended successfully")
                }
            }
    }
    
}

