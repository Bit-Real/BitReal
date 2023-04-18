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
    
    // given a user uid, fetch and return the specified user with a completion
    func fetchUser(withUID uid: String, completion: @escaping(User) -> Void) {
        Firestore.firestore().collection("users")
            .document(uid)
            .getDocument { snapshot, _ in
                guard let snapshot = snapshot else { return }
                guard let user = try? snapshot.data(as: User.self) else { return }
                completion(user)
            }
    }
    
    // fetches all users from Firestore under the users collection
    func fetchAllUsers(completion: @escaping([User]) -> Void) -> ListenerRegistration {
        var users = [User]()
        let listener = Firestore.firestore().collection("users").addSnapshotListener { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            documents.forEach { document in
                guard let user = try? document.data(as: User.self) else { return }
                users.append(user)
            }
            completion(users)
        }
        return listener
    }
    
    // fetches all friends of this current user with an array of users completion
    func fetchAllFriends(completion: @escaping ([User]) -> Void) -> ListenerRegistration {
        var friends = [User]()
        guard let uid = Auth.auth().currentUser?.uid else { fatalError("No current user") }
        
        let listener = Firestore.firestore().collection("users").document(uid).collection("friends")
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    print("Error getting all friends documents: \(error)")
                    return
                }
                guard let documents = snapshot?.documents else { return }
                
                let dispatchGroup = DispatchGroup()
                documents.forEach { document in
                    dispatchGroup.enter()
                    self.fetchUser(withUID: document.documentID) { fetchedFriend in
                        friends.append(fetchedFriend)
                        dispatchGroup.leave()
                    }
                }
                dispatchGroup.notify(queue: .main) {
                    completion(friends)
                }
            }
        return listener
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
        
        // added friendUser as a friend. send a notification to them
        //notification.addFollowNotification(followedUserID: friendUID, followedUserName: friendUser.username)
        
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
    
    // given a User, remove them from currentUser's friend's list
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

