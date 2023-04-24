//
//  ProfileViewModel.swift
//  BitReal
//
//  Created by Ali Al-Adhami on 4/18/23.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseAuth

class ProfileViewModel: ObservableObject {
    
    @Published var user: User?
    private var listener: ListenerRegistration?

    init() {
        fetchUser()
    }
    
    deinit {
        listener?.remove()
    }

    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        listener = Firestore.firestore().collection("users").document(uid).addSnapshotListener { documentSnapshot, error in
            if let error = error {
                print("Error fetching user: \(error)")
                return
            }
            if let document = documentSnapshot {
                self.user = try? document.data(as: User.self)
            }
        }
    }

}

