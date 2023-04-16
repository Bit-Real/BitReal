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

struct NotificationsPage: View {
    let friends: [Friend] = [
        Friend(name: "John Doe", username: "@Johnny", profileImageName: "pic0"),
        Friend(name: "Jane Doe", username: "@JD", profileImageName: "pic1"),
        Friend(name: "Bob Smith", username: "@Bobby", profileImageName: "pic2")
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Profile Page")
                .font(.system(size: 36, weight: .bold))
                .padding()
            
            List(friends) { friend in
                FriendRequestRow(friend: friend)
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
