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
    @Published var searchText = ""
    
    var searchableUsers: [User] {
        let uid = Auth.auth().currentUser?.uid ?? ""
        if searchText.isEmpty {
            return users.filter({
                $0.id != uid
            })
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
        fetchUsers()
    }
    
    // returns all users from the database
    func fetchUsers() {
        service.fetchAllUsers { users in
            self.users = users
        }
    }
    
}
