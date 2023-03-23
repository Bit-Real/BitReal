//
//  FriendsSearchModel.swift
//  BitReal
//
//  Created by Ali Al-Adhami on 3/23/23.
//

import Foundation

class FriendsSearchModel: ObservableObject {
    @Published var users = [User]()
    let service = UserService()
    
    init() {
        fetchUsers()
    }
    
    func fetchUsers() {
        service.fetchAllUsers { users in
            self.users = users
            print("DEBUG: Users:\n \(users)")
        }
    }
}
