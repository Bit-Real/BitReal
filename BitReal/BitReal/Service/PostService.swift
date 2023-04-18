//
//  PostService.swift
//  BitReal
//
//  Created by Ali Al-Adhami on 3/30/23.
//

import Foundation
import Firebase

struct PostService {
    
//    @EnvironmentObject var authentication: AuthViewModel
//    var notification = NotificationViewModel()
//    var userService = UserService()
   
    
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
    
    // fetches all posts by all users from the posts collection in Firestore
    func fetchPosts(completion: @escaping ([Post]) -> Void) {
        Firestore.firestore().collection("posts")
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
    
    func addComment(_ commentText: String, to post: Post, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let commentData: [String: Any] = [
            "text": commentText,
            "userId": uid,
            "postId": post.id!,
            "timestamp": Timestamp()
        ]

        let postCommentsRef = Firestore.firestore().collection("posts").document(post.id!).collection("comments")
        postCommentsRef.addDocument(data: commentData) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    
        
//        guard let postAuthUser = post.user else {return}
//        notification.addCommentNotification(authUserID: postAuthUser.id!, authUserName: postAuthUser.username, postID: post.id!)
    }


    
}
