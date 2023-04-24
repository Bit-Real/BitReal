//
//  FollowerCardViewModel.swift
//  BitReal
//
//  Created by Don Nguyen on 4/23/23.
//
import Foundation

class FollowerCardViewModel: ObservableObject {
    
    @Published var userService = UserService()
    @Published var userID: String
    
    init(userID: String) {
        self.userID = userID
    }
    
    // allows user to follow someone back from notification inbox
    func follow() {
        userService.fetchUser(withUID: userID) { (User) in
            self.userService.beFriends(User) {
            }
        }
    }
    
}
