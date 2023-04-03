//
//  PostService.swift
//  BitReal
//
//  Created by Ali Al-Adhami on 3/30/23.
//

import Foundation
import Firebase

struct PostService {
    
    func uploadPost(caption: String, completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let data = ["uid": uid,
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
    
    func fetchPosts(completion: @escaping([Post]) -> Void) {
        Firestore.firestore().collection("posts")
            .order(by: "timestamp", descending: true)
            .getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            let posts = documents.compactMap({ try? $0.data(as: Post.self) })
            completion(posts)
        }
    }
    
    func fetchPost(forUid uid: String, completion: @escaping([Post]) -> Void) {
        Firestore.firestore().collection("posts")
            .whereField("uid", isEqualTo: uid)
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                let posts = documents.compactMap({ try? $0.data(as: Post.self) })
                completion(posts.sorted(by: {$0.timestamp.dateValue() > $1.timestamp.dateValue()} ))
            }
    }
    
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

    
}
