//
//  CommentViewModel.swift
//  BitReal
//
//  Created by Ali Al-Adhami on 4/23/23.
//

import Foundation
import SwiftUI

class CommentViewModel: ObservableObject {
    
    @Published var comments = [Comment]()
    let userService = UserService()
    let postService = PostService()
    
    init(postId: String) {
        fetchComments(postId: postId)
    }
    
    // fethces all comments under the specified post
    func fetchComments(postId: String) {
        postService.fetchComments(postId: postId) { comments in
            self.comments = comments
        }
    }
    
    // adds a new comment to the specified post with the given caption
    func addComment(postId: String, caption: String, completion: @escaping (Bool) -> Void) {
        postService.submitComment(postId: postId, caption: caption) { result in
            completion(result)
        }
    }

}
