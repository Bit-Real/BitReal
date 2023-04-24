//
//  CommentNotificationsCard.swift
//  BitReal
//
//  Created by Ali Al-Adhami on 4/24/23.
//

import SwiftUI
import Kingfisher

struct CommentNotificationsCard: View {
    let notification: NotificationModel
    
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
                    
                    Text("@\(notification.friendUserName) commented on your post")
                        .font(.system(size: 16))
                }
                
                Text(notification.comment)
                    .lineLimit(2)
                    .foregroundColor(Color(red: 0.5, green: 0.5, blue: 0.5))
            } .padding()
        }
    }
}
