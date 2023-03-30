//
//  FriendProfileViewModel.swift
//  BitReal
//
//  Created by Ali Al-Adhami on 3/24/23.
//

import Foundation

class FriendProfileViewModel: ObservableObject {
    @Published var user: User
    private let service = UserService()
    
    init(user: User) {
        self.user = user
        isFriends()
    }
    
    func beFriends() {
        service.beFriends(user) {
            self.user.isFriend = true
        }
    }
    
    func unfriend() {
        service.unfriend(user) {
            self.user.isFriend = false
        }
    }
    
    func isFriends() {
        service.isFriends(user) { result in
            if (result) {
                self.user.isFriend = result
            }
        }
    }
}
