// PostDetailView.swift

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct Comment: Identifiable, Codable {
    @DocumentID var id: String?
    let text: String
    let timestamp: Date
    let userId: String
}

struct PostDetailView: View {
    let post: Post
    
    @State private var newComment = ""
    @State private var comments: [Comment] = []
    private let db = Firestore.firestore()
    
    var body: some View {
        VStack {
            // original post at the top
            PostsRowView(post: post)
            
            // comments
            List {
                Section(header: Text("Comments")) {
                    ForEach(comments) { comment in
                        Text(comment.text)
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
        guard !newComment.isEmpty else { return }

        // Create a new comment document in Firestore
        let commentData: [String: Any] = [
            "postId": post.id!,
            "userId": Auth.auth().currentUser!.uid,
            "text": newComment,
            "timestamp": Timestamp()
        ]
        db.collection("comments").addDocument(data: commentData) { error in
            if let error = error {
                print("ERROR: Failed to add new comment. Error: \(error.localizedDescription)")
            } else {
                // Reset the text field and fetch the updated comments
                newComment = ""
                fetchComments()
            }
        }
    }

    private func fetchComments() {
        guard let postId = post.id else { return }
        db.collection("comments")
            .whereField("postId", isEqualTo: postId)
            .order(by: "timestamp")
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    print("Error fetching comments: \(error.localizedDescription)")
                    return
                }
                
                if let snapshot = snapshot {
                    comments = snapshot.documents.compactMap { document in
                        do {
                            var comment = try document.data(as: Comment.self)
                            comment.id = document.documentID
                            return comment
                        } catch {
                            print("Error decoding comment: \(error.localizedDescription)")
                            return nil
                        }
                    }
                }
            }
    }


}
