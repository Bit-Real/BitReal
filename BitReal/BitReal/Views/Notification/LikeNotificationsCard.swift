//
//  LikeNotificationsCard.swift
//  BitReal
//
//  Created by Ali Al-Adhami on 4/24/23.
//

import SwiftUI
import Firebase
import Kingfisher

struct LikeNotificationsCard: View {
    let notification: NotificationModel
    let postID: String
    let ref: DocumentReference
    
    @State private var caption: String = ""
    
    init(notification: NotificationModel) {
        self.notification = notification
        self.postID = notification.postID
        self.ref = Firestore.firestore().collection("posts").document(postID)
    }
    
    var body: some View {
        ZStack (alignment: .leading) {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .shadow(radius: 5)
            
            VStack (alignment: .leading) {
                HStack {
                    KFImage(URL(string: notification.friendProfilePic))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                        .cornerRadius(25)
                        .clipped()
                    
                    Text("@\(notification.friendUserName) liked your post")
                        .font(.system(size: 16))
                }
                
                Text(caption)
                    .lineLimit(3)
                    .foregroundColor(Color(red: 0.5, green: 0.5, blue: 0.5))
            }
            .padding()
            .onAppear {
                fetchCaption()
            }
        }
    }
    
    func fetchCaption() {
            ref.getDocument { (document, error) in
                if let error = error {
                    print("Error fetching post caption: \(error.localizedDescription)")
                } else if let document = document, document.exists {
                    let data = document.data()
                    if let caption = data?["caption"] as? String {
                        self.caption = caption
                    } else {
                        print("Caption not found in document")
                    }
                } else {
                    print("Post document not found")
                }
            }
        }
}
