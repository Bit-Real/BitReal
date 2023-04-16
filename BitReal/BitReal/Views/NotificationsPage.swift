//
//  NotificationsPage.swift
//  BitReal
//
//  Created by Emmanuel Ihim Jr on 4/10/23.
//

import SwiftUI

struct Friend: Identifiable {
    let id = UUID()
    let name: String
    let username: String
    let profileImageName: String
    let comment: String
}

struct TestUser: Identifiable {
    let id = UUID()
    let post: String
}

struct FriendRequestRow: View {
    let friend: Friend
    
    var body: some View {
            HStack {
                Image(friend.profileImageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .cornerRadius(50)
                    .clipped()
                
                VStack (alignment: .leading){
                    Text(friend.name)
                        .bold()
                        .font(.system(size: 20))
                        
                    Text(friend.username)
                        .font(.system(size: 15))
                        .foregroundColor(.gray)
                    
                    HStack {
                        Button(action: {
                            print("Confirm Button Pressed")
                        }, label: {
                            Text("Confirm")
                                .foregroundColor(.white)
                                .padding(.horizontal, 30)
                                .padding(.vertical, 10)
                                .background(Color.blue)
                                .cornerRadius(5)
                                .bold()
                        }) .buttonStyle(.borderless)
                        
                        Button(action: {
                            print("Delete Button Pressed")
                        }, label: {
                            Text("Delete")
                                .foregroundColor(.black)
                                .padding(.horizontal, 30)
                                .padding(.vertical, 10)
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(5)
                                .bold()
                        })
                    } .buttonStyle(.borderless)
                    
                }
            }
            .padding(.vertical, 10)
    }
}

struct FollowerNotificationsCard: View {
    let friend: Friend
    
    var body: some View {
        ZStack (alignment: .leading) {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .shadow(radius: 5)
            HStack {
                Image(friend.profileImageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .cornerRadius(25)
                    .clipped()
                
                Text("\(friend.username) is following you")
                    .font(.system(size: 16))
                    .lineLimit(1)
                    .minimumScaleFactor(0.9)
                
                
                Spacer()
                
                Button(action: {
                    print("Confirm Button Pressed")
                }, label: {
                    Text("Follow")
                        .foregroundColor(.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 10)
                        .background(Color.blue)
                        .cornerRadius(5)
                        .bold()
                }) .buttonStyle(.borderless)
            } .padding()
        }
        .frame(height: 80)
    }
}

struct LikeNotificationsCard: View {
    let friend: Friend
    let user: TestUser
    
    var body: some View {
        ZStack (alignment: .leading) {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .shadow(radius: 5)
            
            VStack (alignment: .leading) {
                HStack {
                    Image(friend.profileImageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                        .cornerRadius(25)
                        .clipped()
                    
                    Text("\(friend.username) liked your post")
                        .font(.system(size: 16))
                }
                
                Text("\(user.post)")
                    .lineLimit(3)
                    .foregroundColor(Color(red: 0.5, green: 0.5, blue: 0.5))
            } .padding()
        }
    }
}

struct CommentNotificationsCard: View {
    let friend: Friend
    let user: TestUser
    
    var body: some View {
        ZStack (alignment: .leading) {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .shadow(radius: 5)
            
            VStack (alignment: .leading) {
                HStack {
                    Image(friend.profileImageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                        .cornerRadius(25)
                        .clipped()
                    
                    Text("\(friend.username) commented on your post")
                        .font(.system(size: 16))
                }
                
                Text("\(friend.comment)")
                    .lineLimit(2)
                    .foregroundColor(Color(red: 0.5, green: 0.5, blue: 0.5))
            } .padding()
        }
    }
}


struct NotificationsPage: View {
    let friends: [Friend] = [
        Friend(name: "John Doe", username: "@Johnny", profileImageName: "pic0", comment: "Great job completing your habit today!"),
        Friend(name: "Jane Doe", username: "@JD", profileImageName: "pic1", comment: "Wow, I can't believe how JACKED you look now. Congrats on the 6-pack Dad :)"),
        Friend(name: "Bob Smith", username: "@Bobby", profileImageName: "pic2", comment: "Keep killing it 🔥")
    ]
    
    let users: [TestUser] = [
        TestUser(post: "Up branch to easily missed by do. Admiration considered acceptance too led one melancholy expression. Are will took form the nor true. Winding enjoyed minuter her letters evident use eat colonel. He attacks observe mr cottage inquiry am examine gravity. Are dear but near left was. Year kept on over so as this of. She steepest doubtful betrayed formerly him. Active one called uneasy our seeing see cousin tastes its. Ye am it formed indeed agreed relied piqued."),
        TestUser(post: "Improve ashamed married expense bed her comfort pursuit mrs. Four time took ye your as fail lady."),
        TestUser(post: "test post 3"),
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Notifications Inbox")
                .font(.system(size: 36, weight: .bold))
                .padding()
            
            List(Array(zip(friends, users)), id: \.0.id) { (friend, user) in
                FollowerNotificationsCard(friend: friend)
                    .listRowSeparator(.hidden)
                LikeNotificationsCard(friend: friend, user: user)
                    .listRowSeparator(.hidden)
                CommentNotificationsCard(friend: friend, user: user)
                    .listRowSeparator(.hidden)
            }
            .listStyle(PlainListStyle())
        }
        
    }
}

struct NotificationsPage_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsPage()
    }
}
