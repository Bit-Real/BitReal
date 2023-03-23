//
//  FriendsSearchModel.swift
//  BitReal
//
//  Created by Ali Al-Adhami on 3/23/23.
//

import Foundation

class FriendsSearchModel: ObservableObject {
    @Published var users = [User]()
    @Published var searchText = ""
    
    var searchableUsers: [User] {
        if searchText.isEmpty {
            return users
        }
        let queryLC = searchText.lowercased()
        return users.filter({
            $0.username.lowercased().contains(queryLC) ||
            $0.fullname.lowercased().contains(queryLC)
        })
    }
    
    let service = UserService()
    
    init() {
        fetchUsers()
    }
    
    // returns all users from the database
    func fetchUsers() {
        service.fetchAllUsers { users in
            self.users = users
        }
    }
}
