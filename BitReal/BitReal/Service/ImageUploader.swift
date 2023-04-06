//
//  ImageUpload.swift
//  BitReal
//
//  Created by Ali Al-Adhami on 4/4/23.
//

import Firebase
import FirebaseStorage
import UIKit

struct ImageUploader {
    // given a UIImage, upload it to Firebase Storage with a URL string completion
    static func uploadImage(image: UIImage, completion: @escaping(String) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_image/\(filename)")
        
        ref.putData(imageData, metadata: nil) { _, error in
            if let error = error {
                print("ERROR: failed to upload user supplied image, \(error.localizedDescription)")
                return
            }
            ref.downloadURL { imageURL, _ in
                guard let imageURL = imageURL?.absoluteString else { return }
                completion(imageURL)
            }
        }
    }
}
