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
    @Published var tempUserSession: FirebaseAuth.User?
    @Published var didAuthenticateUser = false
    @Published var currentUser: User?
    private let service = UserService()
    
    init() {
        self.userSession = Auth.auth().currentUser
        self.fetchUser()
    }
    
    func login(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error as NSError? {
                print("\(error.localizedDescription)")
            } else {
                guard let user = result?.user else { return }
                self.userSession = user
                self.fetchUser()
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
                    print("DEBUG: created user")
                    guard let user = result?.user else { return }
                    self.tempUserSession = user
                    print("Sign Up with email \(email) and username \(username)")
                    
                    // user info dict to be stored in Firestore database
                    let userData = ["email": email,
                                    "username": username.lowercased(),
                                    "fullname": fullname,
                                    "uid": user.uid,
                                    "profileImageURL": "https://images.unsplash.com/photo-1517849845537-4d257902454a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80"]
                    Firestore.firestore().collection("users").document(user.uid)
                        .setData(userData) { _ in
                            self.didAuthenticateUser = true
                            print("Uploaded user data to Firestore")
                        }
                    self.fetchUser()
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
    
    func uploadProfileImage(_ image: UIImage) {
        guard let uid = tempUserSession?.uid else { return }
        ImageUploader.uploadImage(image: image) { profileImageURL in
            Firestore.firestore().collection("users")
                .document(uid).updateData(["profileImageURL": profileImageURL]) { _ in
                    self.userSession = self.tempUserSession
                    self.fetchUser()
                }
        }
    }
    
    func fetchUser() {
        guard let uid = self.userSession?.uid else { return }
        // once info fetched, set currentUser field
        service.fetchUser(withUID: uid) { user in
            self.currentUser = user
        }
    }
}
