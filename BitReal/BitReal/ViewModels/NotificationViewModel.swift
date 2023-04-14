//
//  NotificationViewModel.swift
//  BitReal
//
//  Created by Don Nguyen on 4/14/23.
//

import Foundation
import Firebase

class NotificationViewModel: ObservableObject {
    
    @Published var list = [NotificationModel]()
    private var listener: ListenerRegistration?
    
    init() {
        getData { success in
            // data retrieved successfully 
        }
    }
    
    deinit {
        listener?.remove()
    }
    
    func addFollowNotification(friendUserID: String, friendName: String) {
        let db = Firestore.firestore()
       
        let data = ["userID": String(Auth.auth().currentUser!.uid),
                    "friendUserID": friendUserID,
                    "type": "Follow",
                    "postID": "None",
                    "habitID": "None",
                    "alarm": Date(),
                    "timestamp": Date(),
                    "content": "\(friendName) followed you!"] as [String : Any]
        db.collection("notifications").addDocument(data: data) { error in
            
            if error == nil {
                print("Successfully added habit to Firestore")
            }
            else {
                // error handling to be added
            }
        }
    }
    
    func addLikeNotification(friendUserID: String, friendName: String, postID: String) {
        let db = Firestore.firestore()
        let data = ["userID": String(Auth.auth().currentUser!.uid),
                    "friendUserID": friendUserID,
                    "type": "Like",
                    "postID": postID,
                    "habitID": "None",
                    "alarm": Date(),
                    "timestamp": Date(),
                    "content": "\(friendName) liked your post!"] as [String : Any]
        db.collection("notifications").addDocument(data: data) { error in
            
            if error == nil {
                print("Successfully added habit to Firestore")
            }
            else {
                // error handling to be added
            }
        }
    }
    
    func addCommentNotification(friendUserID: String, friendName: String, postID: String) {
        let db = Firestore.firestore()
        let data = ["userID": String(Auth.auth().currentUser!.uid),
                    "friendUserID": friendUserID,
                    "type": "Comment",
                    "postID": postID,
                    "habitID": "None",
                    "alarm": Date(),
                    "timestamp": Date(),
                    "content": "\(friendName) commented on your post!"] as [String : Any]
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
