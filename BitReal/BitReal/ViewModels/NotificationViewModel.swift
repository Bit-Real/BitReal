//
//  NotificationViewModel.swift
//  BitReal
//
//  Created by Don Nguyen on 4/14/23.
//

import Foundation
import Firebase

class NotificationViewModel: ObservableObject {
    
 //   @Published var authentication = AuthViewModel()
    @Published var list = [NotificationModel]()
    private var listener: ListenerRegistration?
    var authentication = AuthViewModel()
    
    init() {
        getData { success in
            // data retrieved successfully 
        }
    }
    
    deinit {
        listener?.remove()
    }
    
    
    func addFollowNotification(followedUserID: String, followedUserName: String) {
        let currentUser = authentication.currentUser
        let db = Firestore.firestore()
        let data = ["userID": followedUserID,
                    "friendUserID": String(currentUser.id!),
                    "friendProfilePic": currentUser.profileImageURL,
                    "type": "Follow",
                    "postID": "None",
                    "habitID": "None",
                    "alarm": Date(),
                    "timestamp": Date(),
                    "content": "\(currentUser.username) followed you!"] as [String : Any]
        db.collection("notifications").addDocument(data: data) { error in
            
            if error == nil {
                print("Successfully added habit to Firestore")
            }
            else {
                // error handling to be added
            }
        }
    }
    
    func addLikeNotification(authUserID: String, authUserName: String, postID: String) {
        let currentUser = authentication.currentUser!
        let db = Firestore.firestore()
        let data = ["userID": authUserID,
                    "friendUserID": currentUser.id!,
                    "friendProfilePic": currentUser.profileImageURL,
                    "type": "Like",
                    "postID": postID,
                    "habitID": "None",
                    "alarm": Date(),
                    "timestamp": Date(),
                    "content": "\(currentUser.username) liked your post!"] as [String : Any]
        db.collection("notifications").addDocument(data: data) { error in
            
            if error == nil {
                print("Successfully added habit to Firestore")
            }
            else {
                // error handling to be added
            }
        }
    }
    
    func addCommentNotification(authUserID: String, authUserName: String, postID: String) {
        let currentUser = authentication.currentUser!
        let db = Firestore.firestore()
        let data = ["userID": authUserID,
                    "friendUserID": currentUser.id!,
                    "friendProfilePic": currentUser.profileImageURL,
                    "type": "Comment",
                    "postID": postID,
                    "habitID": "None",
                    "alarm": Date(),
                    "timestamp": Date(),
                    "content": "\(currentUser.username) commented on your post!"] as [String : Any]
        db.collection("notifications").addDocument(data: data) { error in
            
            if error == nil {
                print("Successfully added habit to Firestore")
            }
            else {
                // error handling to be added
            }
        }
    }
    
    func addHabitNotification(habitID: String, habitName: String, alarm: Date) {
        let db = Firestore.firestore()
        let data = ["userID": String(Auth.auth().currentUser!.uid),
                    "friendUserID": "None",
                    "friendProfilePic": "None",
                    "type": "Habit",
                    "postID": "None",
                    "habitID": habitID,
                    "alarm": alarm,
                    "timestamp": alarm,
                    "content": "Here's a reminder for \(habitName)!"] as [String : Any]
        db.collection("notifications").addDocument(data: data) { error in
            
            if error == nil {
                print("Successfully added habit to Firestore")
            }
            else {
                // error handling to be added
            }
        }
        
    }
    
    func getData(completion: @escaping(Bool) -> Void) {
        let db = Firestore.firestore()

        // Set up a snapshot listener
        listener = db.collection("notifications").whereField("userID", isEqualTo: Auth.auth().currentUser!.uid).addSnapshotListener { (snapshot, error) in
            if error == nil {
                if let snapshot = snapshot {
                    self.list = snapshot.documents.compactMap({ try? $0.data(as: NotificationModel.self) })
                    self.list = self.list.sorted(by: { $0.timestamp > $1.timestamp })
                    completion(true)
                }
            } else {
                // handle error
            }
        }
    }
}
