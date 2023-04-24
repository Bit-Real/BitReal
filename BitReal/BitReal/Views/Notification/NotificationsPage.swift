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
