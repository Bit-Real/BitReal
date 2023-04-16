// PostDetailView.swift

import SwiftUI
import Firebase
import FirebaseFirestoreSwift
import Kingfisher

struct FirebaseComment: Codable, Identifiable {
    @DocumentID var id: String?
    var userId: String
    var text: String
    var timestamp: Timestamp
    var postId: String?
    var userName: String?
    var userProfilePicUrl: String?
    
}

struct PostDetailView: View {
    
    @ObservedObject var notification = NotificationViewModel()
    @State private var newComment = ""
    @State private var comments: [FirebaseComment] = []
    private let db = Firestore.firestore()
    let post: Post
    
    var body: some View {
        VStack {
            // original post at the top
            PostsRowView(post: post)
            List {
                Section(header: Text("Comments")) {
                    ForEach(comments) { comment in
                        HStack {
                            if let profilePicUrl = comment.userProfilePicUrl {
                                KFImage(URL(string: profilePicUrl))
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(Color(.systemBlue))
                                    .cornerRadius(30)
                            } else {
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(.gray)
                            }
                            VStack(alignment: .leading) {
                                Text("@\(comment.userName ?? "")")
                                    .foregroundColor(.gray)
//                                Text(comment.timestamp.dateValue(), style: .relative)
//                                       .foregroundColor(.gray)
//                                       .font(.caption)
                                Text(comment.text)
                                    .font(.body)
                            }
                        }
                    }
                }
            }



            
            // text field to write a new comment
            HStack {
                TextField("Write a comment...", text: $newComment)
                Button("Submit") {
                    submitComment()
                }
            }
            .padding()
        }
        .onAppear {
            fetchComments()
        }
    }
    
    private func submitComment() {
        guard let postId = post.id, !newComment.isEmpty else { return }

        // Create a new comment document in Firestore
        let commentData: [String: Any] = [
            "userId": Auth.auth().currentUser!.uid,
            "text": newComment,
            "timestamp": Timestamp(),
            "postId": postId // Add the postId field
        ]
        db.collection("posts").document(postId).collection("comments").addDocument(data: commentData) { error in
            if let error = error {
                print("ERROR: Failed to add new comment. Error: \(error.localizedDescription)")
            } else {
                notification.addCommentNotification(authUserID: post.user!.id!, authUserName: post.user!.username, postID: post.uid, comment: newComment)
                // Reset the text field and fetch the updated comments
                newComment = ""
                fetchComments()
            }
        }
    }
    
    func fetchUser(withUID uid: String, completion: @escaping(User) -> Void) {
        Firestore.firestore().collection("users")
            .document(uid)
            .getDocument { snapshot, _ in
                guard let snapshot = snapshot else { return }
                guard let user = try? snapshot.data(as: User.self) else { return }
                completion(user)
            }
    }
    
    private func fetchComments() {
        guard let postId = post.id else { return }
        db.collection("posts").document(postId).collection("comments")
            .order(by: "timestamp")
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    print("Error fetching comments: \(error.localizedDescription)")
                    return
                }

                if let snapshot = snapshot {
                    var newComments: [FirebaseComment] = []
                    let dispatchGroup = DispatchGroup()
                    for document in snapshot.documents {
                        dispatchGroup.enter()
                        do {
                            var comment = try document.data(as: FirebaseComment.self)
                            comment.id = document.documentID
                            comment.postId = postId // Set the postId property
                            
                            // Fetch user info for the comment
                            let userId = comment.userId
                            fetchUser(withUID: userId) { user in
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
                        comments = newComments
                    }
                }
            }
    }

    
}
