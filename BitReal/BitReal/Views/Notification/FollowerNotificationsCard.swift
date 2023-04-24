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
    @State private var isLoading: Bool = false
    @State private var isComplete: Bool = false
    @State private var rotationDegrees: Double = 0
    
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
                
                if !isComplete {
                    Button(action: {
                        let followCard = FollowerCardViewModel(userID: notification.friendUserID)
                        isLoading = true

                        followCard.follow {
                            isLoading = false
                            withAnimation(.easeInOut(duration: 0.25)) {
                                isComplete = true
                            }

                        }
                        
                        notifications.addFollowNotification(followedUserID: notification.friendUserID,
                                                            followedUserName: notification.friendUserName)

                    }, label: {
                        ZStack {
                            if isLoading {
                                Circle()
                                    .trim(from: 0, to: 0.7)
                                    .stroke(Color("Purple"), lineWidth: 5)
                                    .frame(width: 20, height: 20)
                                    .rotationEffect(Angle(degrees: rotationDegrees))
                                    .background(.white)
                                    .onAppear() {
                                        withAnimation(Animation.linear(duration: 0.5).repeatForever(autoreverses: false)) {
                                            startSpinner()
                                        }
                                    }
                            } else {
                                Text("Follow")
                                    .foregroundColor(.white)
                                    .bold()
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 10)
                                    .background(Color("Purple"))
                                    .cornerRadius(5)
                            }
                        }
                        
                    })
                    .buttonStyle(.borderless)
                } else {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 24))
                        .foregroundColor(Color("Purple"))
                }
                
            } .padding()
        }
        .frame(height: 80)
    }
    
    private func startSpinner() {
        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
            rotationDegrees += 10
        }
    }
    
}
