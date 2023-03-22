//
//  AuthViewModel.swift
//  BitReal
//
//  Created by Ali Al-Adhami on 3/21/23.
//

import SwiftUI
import Firebase

class AuthViewModel: ObservableObject {
    // if no user is logged in, this will be nil
    @Published var userSession: FirebaseAuth.User?
    
    init() {
        self.userSession = Auth.auth().currentUser
    }
    
    func login(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error as NSError? {
                print("\(error.localizedDescription)")
            } else {
                guard let user = result?.user else { return }
                self.userSession = user
                print("Sign In with email \(email)")
            }
        }
    }
    
    func signup(withEmail email: String, password: String, confirmPassword: String, fullname: String, username: String) {
        if confirmPassword != password {
            print("Please enter correct password!")
        } else {
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                if let error = error as NSError? {
                    print("\(error.localizedDescription)")
                    return
                } else {
                    guard let user = result?.user else { return }
                    self.userSession = user
                    print("Sign Up with email \(email) and username \(username)")
                    
                    // user info dict to be stored in Firestore database
                    let userData = ["email": email,
                                    "username": username.lowercased(),
                                    "fullname": fullname,
                                    "uid": user.uid]
                    Firestore.firestore().collection("users").document(user.uid)
                        .setData(userData) { _ in
                            print("Uploaded user data to Firestore")
                        }
                }
            }
        }
    }
    
    func signout() {
        do {
            try Auth.auth().signOut()
            userSession = nil
        } catch {
            print("Sign out error")
        }
    }
}
