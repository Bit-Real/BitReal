//
//  FollowerNotificationsCard.swift
//  BitReal
//
//  Created by Ali Al-Adhami on 4/24/23.
//

import SwiftUI
import Kingfisher

struct FollowerNotificationsCard: View {
    @ObservedObject var notifications = NotificationViewModel()
    let notification: NotificationModel
    
    var body: some View {
        ZStack (alignment: .leading) {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .shadow(radius: 5)
            HStack {
                KFImage(URL(string: notification.friendProfilePic))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .cornerRadius(25)
                    .clipped()
                
                Text("@\(notification.friendUserName) is following you")
                    .font(.system(size: 16))
                    .lineLimit(1)
                    .minimumScaleFactor(0.9)
                
                
                Spacer()
                
                Button(action: {
                    print("Confirm Button Pressed")
                    let followCard = FollowerCardViewModel(userID: notification.friendUserID)
                    followCard.follow()
                    notifications.addFollowNotification(followedUserID: notification.friendUserID, followedUserName: notification.friendUserName)
                    
                }, label: {
                    Text("Follow")
                        .foregroundColor(.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 10)
                        .background(Color("Purple"))
                        .cornerRadius(5)
                        .bold()
                }) .buttonStyle(.borderless)
            } .padding()
        }
        .frame(height: 80)
    }
}
