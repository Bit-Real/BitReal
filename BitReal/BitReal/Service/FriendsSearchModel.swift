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
    private var listenerRegistration: ListenerRegistration?
    
    // search for searchText inside users array, exclude current user
    var searchableUsers: [User] {
        let uid = Auth.auth().currentUser?.uid ?? ""

        if searchText.isEmpty {
            return Array(Set(friends))
        }
        
        let queryLC = searchText.lowercased()
        let filteredUsers = users.filter({
            (
                $0.username.lowercased().contains(queryLC) ||
                $0.fullname.lowercased().contains(queryLC)
            ) &&
            $0.id != uid
        })
        
        // use a Set to remove duplicate Users
        return Array(Set(filteredUsers))
    }
    
    let service = UserService()
    
    init() {
        fetchFriends()
        fetchUsers()
    }
    
    deinit {
        listenerRegistration?.remove()
    }
    
    // returns all friends/followers of this current user
    func fetchFriends() {
        listenerRegistration = service.fetchAllFriends { friends in
            self.friends = friends
        }
    }

    // returns all users from the database
    func fetchUsers() {
        listenerRegistration = service.fetchAllUsers { users in
            self.users = users
        }
    }
    
}
