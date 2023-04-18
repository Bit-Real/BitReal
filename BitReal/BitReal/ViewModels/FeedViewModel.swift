//
//  FeedViewModel.swift
//  BitReal
//
//  Created by Ali Al-Adhami on 3/31/23.
//

import Foundation
import Firebase

class FeedViewModel: ObservableObject {
    
    @Published var posts = [Post]()
    let service = PostService()
    let userService = UserService()
    private var listenerRegistration: ListenerRegistration?
    
    init() {
        fetchPosts()
    }
    
    deinit {
        listenerRegistration?.remove()
    }
    
    func fetchPosts() {
        listenerRegistration = service.fetchPosts { posts in
            self.posts = posts
            for i in 0 ..< posts.count {
                let uid = posts[i].uid
                self.userService.fetchUser(withUID: uid) { user in
                    self.posts[i].user = user
                }
            }
        }
    }
    
}
