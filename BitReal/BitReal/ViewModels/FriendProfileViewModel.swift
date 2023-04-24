//
//  FriendProfileViewModel.swift
//  BitReal
//
//  Created by Ali Al-Adhami on 3/24/23.
//

import Foundation

class FriendProfileViewModel: ObservableObject {
    
    @Published var user: User
    @Published var posts = [Post]()
    
    private let postService = PostService()
    private let userService = UserService()
    
    init(user: User) {
        self.user = user
        self.fetchUserPosts()
        isFriends()
    }
    
    // makes this other user a friend of the current user
    func beFriends() {
        userService.beFriends(user) {
            self.user.isFriend = true
        }
    }
    
    // removes this user from this other user's friend's list
    func unfriend() {
        userService.unfriend(user) {
            self.user.isFriend = false
        }
    }
    
    // checks if this other user and logged in user are friends
    func isFriends() {
        userService.isFriends(user) { result in
            if (result) {
                self.user.isFriend = result
            }
        }
    }
    
    // fetches all posts made by this user
    func fetchUserPosts() {
        guard let uid = user.id else { return }
        postService.fetchPost(forUid: uid) { posts in
            self.posts = posts
            for i in 0 ..< posts.count {
                self.posts[i].user = self.user
            }
        }
    }
    
}
