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
    
    func uploadPost(withCaption caption: String) {
        service.uploadPost(caption: caption) { success in
            if success {
                self.didUploadPost = true
            } else {
                // handle error with User
            }
        }
    }
}
