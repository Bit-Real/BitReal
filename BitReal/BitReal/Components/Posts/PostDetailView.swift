// PostDetailView.swift

import SwiftUI
import Firebase
import FirebaseFirestoreSwift
import Kingfisher

struct PostDetailView: View {
    
    @ObservedObject var notification = NotificationViewModel()
    @ObservedObject var commentViewModel: CommentViewModel
    @State private var newComment = ""
    private let db = Firestore.firestore()
    let post: Post
    
    init(post: Post) {
        self.post = post
        commentViewModel = CommentViewModel(postId: post.id ?? "")
    }
    
    var body: some View {
        VStack {
            // original post at the top
            PostsRowView(post: post)
            List {
                Section(header: Text("Comments")) {
                    ForEach(commentViewModel.comments) { comment in
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
                                HStack {
                                    Text("@\(comment.userName ?? "")")
                                        .foregroundColor(.gray)
                                    Spacer()
                                    Text("\(Utility.convertTimestampToString(timestamp: comment.timestamp))")
                                           .foregroundColor(.gray)
                                           .font(.caption)
                                }
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
//                    submitComment()
                    commentViewModel.addComment(postId: post.id ?? "", caption: newComment) { result in
                        if result {
                            notification.addCommentNotification(authUserID: post.user!.id!,
                                                                authUserName: post.user!.username,
                                                                postID: post.uid,
                                                                comment: newComment)
                            // Reset the text field and fetch the updated comments
                            newComment = ""
                            commentViewModel.fetchComments(postId: post.id ?? "")
                            print("Success. Comment added!")
                        } else {
                            print("Failed to add comment")
                        }
                    }
                }
            }
            .padding()
        }
        .onAppear {
            commentViewModel.fetchComments(postId: post.id ?? "")
        }
    }

}
