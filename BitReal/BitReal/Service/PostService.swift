//
//  PostService.swift
//  BitReal
//
//  Created by Ali Al-Adhami on 3/30/23.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

struct PostService {
    
    var userService = UserService()
    private let db = Firestore.firestore()
    
    // given a caption, create a new entry in Firestore under posts collection
    // with a Bool completion
    func uploadPost(caption: String, habitId: String, completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let data = ["uid": uid,
                    "habitId": habitId,
                    "caption": caption,
                    "likes": 0,
                    "timestamp": Timestamp(date: Date())] as [String: Any]
        Firestore.firestore().collection("posts").document().setData(data) { error in
            if let error = error {
                print("ERROR: failed uploading post. Error is: \(error.localizedDescription)")
                completion(false)
            } else {
                print("Uploaded a post")
                completion(true)
            }
        }
    }
    
    // Fetches all posts by all users from the posts collection in Firestore
    func fetchPosts(completion: @escaping ([Post]) -> Void) -> ListenerRegistration {
        let listener = db.collection("posts")
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    print("Error getting documents: \(error)")
                    return
                }
                guard let documents = snapshot?.documents else { return }

                let dispatchGroup = DispatchGroup()
                var fetchedPosts: [Post] = []

                for document in documents {
                    dispatchGroup.enter()
                    if let post = try? document.data(as: Post.self) {
                        self.fetchHabit(withUID: post.habitId) { habit in
                            var newPost = post
                            newPost.habit = habit
                            fetchedPosts.append(newPost)
                            dispatchGroup.leave()
                        }
                    } else {
                        dispatchGroup.leave()
                    }
                }

                dispatchGroup.notify(queue: .main) {
                    completion(fetchedPosts.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() }))
                }
            }

        return listener
    }
    
    // given a user uid, fetches all posts by the specifed User
    func fetchPost(forUid uid: String, completion: @escaping([Post]) -> Void) {
        Firestore.firestore().collection("posts")
            .whereField("uid", isEqualTo: uid)
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                
                let dispatchGroup = DispatchGroup()
                var fetchedPosts: [Post] = []
                
                for document in documents {
                    dispatchGroup.enter()
                    if let post = try? document.data(as: Post.self) {
                        fetchHabit(withUID: post.habitId) { habit in
                            var newPost = post
                            newPost.habit = habit
                            fetchedPosts.append(newPost)
                            dispatchGroup.leave()
                        }
                    } else {
                        dispatchGroup.leave()
                    }
                }
                dispatchGroup.notify(queue: .main) {
                    completion(fetchedPosts.sorted(by: {$0.timestamp.dateValue() > $1.timestamp.dateValue()} ))
                }
            }
    }
    
    // fetch and return the habit with the specified id
    func fetchHabit(withUID uid: String, completion: @escaping(HabitModel) -> Void) {
        let db = Firestore.firestore()
        
        db.collection("habits").document(uid).getDocument { snapshot, _ in
            guard let snapshot = snapshot else { return }
            guard let habit = try? snapshot.data(as: HabitModel.self) else { return }
            completion(habit)
        }
    }
    
    // given a Post, update its like counter in Firestore
    func updateLikes(for post: Post, newLikesCount: Int, completion: @escaping (Error?) -> Void) {
        let postRef = Firestore.firestore().collection("posts").document(post.id!)
        postRef.updateData(["likes": newLikesCount]) { error in
            if let error = error {
                print("ERROR: failed updating likes for post. Error is: \(error.localizedDescription)")
                completion(error)
            } else {
                print("Updated likes for post")
                completion(nil)
            }
        }
    }
    
    // given a post id, fetch and return all of its comments in an array
    func fetchComments(postId: String, completion: @escaping([Comment]) -> Void) {
        db.collection("posts").document(postId).collection("comments")
            .order(by: "timestamp")
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    print("Error fetching comments: \(error.localizedDescription)")
                    return
                }

                if let snapshot = snapshot {
                    var newComments: [Comment] = []
                    let dispatchGroup = DispatchGroup()
                    for document in snapshot.documents {
                        dispatchGroup.enter()
                        do {
                            var comment = try document.data(as: Comment.self)
                            comment.id = document.documentID
                            comment.postId = postId // Set the postId property
                            
                            // Fetch user info for the comment
                            let userId = comment.userId
                            userService.fetchUser(withUID: userId) { user in
                                comment.userName = user.username
                                comment.userProfilePicUrl = user.profileImageURL
                                newComments.append(comment)
                                dispatchGroup.leave()
                            }
                        } catch {
                            print("Error decoding comment: \(error.localizedDescription)")
                            dispatchGroup.leave()
                        }
                    }
                    dispatchGroup.notify(queue: .main) {
                        completion(newComments)
                    }
                }
            }
    }
    
    // given a post id and caption, add it as a new comment to the specified post
    func submitComment(postId: String, caption: String, completion: @escaping(Bool) -> Void) {
        // Create a new comment document in Firestore
        let commentData: [String: Any] = [
            "userId": Auth.auth().currentUser!.uid,
            "text": caption,
            "timestamp": Timestamp(),
            "postId": postId
        ]
        db.collection("posts").document(postId).collection("comments").addDocument(data: commentData) { error in
            if let error = error {
                print("ERROR: Failed to add new comment. Error: \(error.localizedDescription)")
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
}
