//
//  NotificationsPage.swift
//  BitReal
//
//  Created by Emmanuel Ihim Jr on 4/10/23.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore
import Kingfisher

struct FollowerNotificationsCard: View {
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
                
                Text("\(notification.friendUserName) is following you")
                    .font(.system(size: 16))
                    .lineLimit(1)
                    .minimumScaleFactor(0.9)
                
                
                Spacer()
        
                Button(action: {
                    print("button pressed")
                    var followCard = FollowerCardViewModel(userID: notification.friendUserID)
                    followCard.follow()
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
                    
                    Text("\(notification.friendUserName) liked your post")
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
                    
                    Text("\(notification.friendUserName) commented on your post")
                        .font(.system(size: 16))
                }
                
                Text(notification.comment)
                    .lineLimit(2)
                    .foregroundColor(Color(red: 0.5, green: 0.5, blue: 0.5))
            } .padding()
        }
    }
}

struct NotificationsPage: View {
    @State var notifications: [NotificationModel] = []
    @ObservedObject var notification = NotificationViewModel()
    let db = Firestore.firestore()
    let ref = Firestore.firestore().collection("notifications")
    let user = Auth.auth().currentUser
    let userID: String?
        
    init() {
        if let user = Auth.auth().currentUser {
            self.userID = user.uid
        } else {
            self.userID = nil
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
//            Text("Notifications Inbox")
//                .font(.system(size: 36, weight: .bold))
//                .padding()
            
            List(notification.list, id: \.id) { notification in
                switch notification.type {
                    case "Like":
                        LikeNotificationsCard(notification: notification)
                            .listRowSeparator(.hidden)
                    case "Comment":
                        CommentNotificationsCard(notification: notification)
                            .listRowSeparator(.hidden)
                    case "Follow":
                        FollowerNotificationsCard(notification: notification)
                            .listRowSeparator(.hidden)
                    default:
                        EmptyView()
                    }
            }
            .listStyle(PlainListStyle())
            .onAppear() {
                fetchNotifications()
            }
        }
        .navigationTitle("Notifications Inbox")
        .toolbar {
            Button(action: {
                notification.clearData()
            }) {
                Text("Clear Notifications")
            }
        }
        
    }
    
    func fetchNotifications() {
        guard let userID = userID else {
            return
        }
        ref.whereField("userID", isEqualTo: userID).getDocuments { (snapshot, error) in
            if let error = error {
                print("Error fetching notifications: \(error.localizedDescription)")
                return
            }
            if let snapshot = snapshot {
                self.notifications = snapshot.documents.compactMap { document in
                    try? document.data(as: NotificationModel.self)
                }
                self.notifications = self.notifications.sorted(by: {$0.timestamp > $1.timestamp})
            }
        }
    }
}

struct NotificationsPage_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsPage()
    }
}
