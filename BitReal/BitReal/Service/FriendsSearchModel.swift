//
//  FriendsSearchModel.swift
//  BitReal
//
//  Created by Ali Al-Adhami on 3/23/23.
//

import Foundation
import Firebase

class FriendsSearchModel: ObservableObject {
    
    @Published var users = [User]()
    @Published var friends = [User]()
    @Published var searchText = ""
    
    // search for searchText inside users array, exclude current user
    var searchableUsers: [User] {
        let uid = Auth.auth().currentUser?.uid ?? ""

        if searchText.isEmpty {
            return friends
        }
        
        let queryLC = searchText.lowercased()
        return users.filter({
            (
                $0.username.lowercased().contains(queryLC) ||
                $0.fullname.lowercased().contains(queryLC)
            ) &&
            $0.id != uid
        })
    }
    
    let service = UserService()
    
    init() {
        fetchFriends()
        fetchUsers()
    }
    
    // returns all friends of this current user
    func fetchFriends() {
        service.fetchAllFriends { friends in
            self.friends = friends
        }
    }
    
    // returns all users from the database
    func fetchUsers() {
        service.fetchAllUsers { users in
            self.users = users
        }
    }
    
}
