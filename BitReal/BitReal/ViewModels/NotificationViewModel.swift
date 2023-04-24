//
//  NotificationViewModel.swift
//  BitReal
//
//  Created by Don Nguyen on 4/14/23.
//

import Foundation
import Firebase

class NotificationViewModel: ObservableObject {
    
    @Published var userService = UserService()
    
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
    
    
    func addFollowNotification(followedUserID: String, followedUserName: String) {
       
        userService.fetchUser(withUID: Auth.auth().currentUser!.uid) { (User) in
            let currentUserName = User.username
            let currentUID = User.id!
            let currentProfilePic = User.profileImageURL
            let db = Firestore.firestore()
            let data = ["userID": followedUserID,
                        "friendUserID": currentUID,
                        "friendUserName": currentUserName,
                        "friendProfilePic": currentProfilePic,
                        "type": "Follow",
                        "postID": "None",
                        "comment": "None",
                        "habitID": "None",
                        "alarm": Date(),
                        "timestamp": Date()] as [String : Any]
            db.collection("notifications").addDocument(data: data) { error in
                
                if error == nil {
                    print("Successfully added notification to Firestore")
                }
                else {
                    // error handling to be added
                }
            }
        }
    }
    
    func addLikeNotification(authUserID: String, authUserName: String, postID: String) {
                
        userService.fetchUser(withUID: Auth.auth().currentUser!.uid) { (User) in
            let currentUserName = User.username
            let currentUID = User.id!
            let currentProfilePic = User.profileImageURL
            let db = Firestore.firestore()
            let data = ["userID": authUserID,
                        "friendUserID": currentUID,
                        "friendUserName": currentUserName,
                        "friendProfilePic": currentProfilePic,
                        "type": "Like",
                        "postID": postID,
                        "comment": "None",
                        "habitID": "None",
                        "alarm": Date(),
                        "timestamp": Date()] as [String : Any]
            db.collection("notifications").addDocument(data: data) { error in
                
                if error == nil {
                    print("Successfully added notification to Firestore")
                }
                else {
                    // error handling to be added
                }
            }
        }
    }
    
    func addCommentNotification(authUserID: String, authUserName: String, postID: String, comment: String) {
   
                
        userService.fetchUser(withUID: Auth.auth().currentUser!.uid) { (User) in
            let currentUserName = User.username
            let currentUID = User.id!
            let currentProfilePic = User.profileImageURL
            let db = Firestore.firestore()
            let data = ["userID": authUserID,
                        "friendUserID": currentUID,
                        "friendUserName": currentUserName,
                        "friendProfilePic": currentProfilePic,
                        "type": "Comment",
                        "postID": postID,
                        "comment": comment,
                        "habitID": "None",
                        "alarm": Date(),
                        "timestamp": Date()] as [String : Any]
            db.collection("notifications").addDocument(data: data) { error in
                
                if error == nil {
                    print("Successfully added notification to Firestore")
                }
                else {
                    // error handling to be added
                }
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
                    "comment": "None",
                    "habitID": habitID,
                    "alarm": alarm,
                    "timestamp": alarm,
                    "content": "Here's a reminder for \(habitName)!"] as [String : Any]
        db.collection("notifications").addDocument(data: data) { error in
            
            if error == nil {
                print("Successfully added notification to Firestore")
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
    
    func clearData() {
        let db = Firestore.firestore()
        db.collection("notifications").whereField("userID", isEqualTo: Auth.auth().currentUser!.uid).getDocuments() { (QuerySnapshot, err) in
            if err != nil {
                print("Error: Unable to retrieve documents")
            } else {
                for document in QuerySnapshot!.documents {
                    document.reference.delete()
                }
                self.list.removeAll()
            }
        }
    }
}
