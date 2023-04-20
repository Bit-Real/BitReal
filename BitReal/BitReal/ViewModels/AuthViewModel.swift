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
    
    func login(withEmail email: String,
               password: String,
               completion: @escaping(String) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error as NSError? {
                print("\(error.localizedDescription)")
                completion("\(error.localizedDescription)")
            } else {
                guard let user = result?.user else { return }
                self.userSession = user
                self.fetchUser()
                print("Sign In with email \(email)")
                completion("")
            }
        }
    }
    
    func signup(withEmail email: String,
                password: String,
                confirmPassword: String,
                fullname: String,
                username: String,
                completion: @escaping(String) -> Void) {
        // series of data checks on user input
        if confirmPassword != password {
            print("Please enter correct password!")
            completion("Please ensure passwords are matching")
        } else if username.isEmpty {
            completion("Please enter a username")
            return
        } else if username.contains(" ") {
            completion("Usernames may not have white spaces")
            return
        } else if fullname.isEmpty {
            completion("Please enter your full name")
            return
        } else {
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                if let error = error as NSError? {
                    print("\(error.localizedDescription)")
                    completion("\(error.localizedDescription)")
                    return
                } else {
                    print("Sign Up with email \(email) and username \(username)")
                    guard let user = result?.user else { return }
                    self.tempUserSession = user
                    
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
                    completion("")
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
    
    func updateProfileImage(_ image: UIImage, completion: @escaping () -> Void) {
        print("updateProfileImage first line")
        guard let uid = userSession?.uid else { return }
        ImageUploader.uploadImage(image: image) { profileImageURL in
            print("URL is: \(profileImageURL)")
            Firestore.firestore().collection("users")
                .document(uid).updateData(["profileImageURL": profileImageURL]) { _ in
                    completion()
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
