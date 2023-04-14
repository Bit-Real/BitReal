//
//  HomeViewModel.swift
//  BitReal
//
//  Created by Ali Al-Adhami on 3/30/23.
//

import Foundation
import Firebase

class PostViewModel: ObservableObject {
    
    @Published var didUploadPost = false
    @Published var revealDetails = false
    let service = PostService()
    
    // given a post caption, upload data into Firestore
    func uploadPost(withCaption caption: String, habitId: String) {
        service.uploadPost(caption: caption, habitId: habitId) { success in
            if success {
                self.didUploadPost = true
            } else {
                // handle error with User
            }
        }
    }
}
