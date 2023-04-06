//
//  FriendCard.swift
//  BitReal
//
//  Created by Ali Al-Adhami on 2/24/23.
//

import SwiftUI
import Kingfisher

struct FriendCard: View {
    
    let user: User
    
    var body: some View {
        NavigationLink {
            FriendProfilePage(user: user)
        } label: {
            HStack {
                // freind's image
                KFImage(URL(string: user.profileImageURL))
                    .resizable()
                    .frame(width: 64, height: 64)
                    .foregroundColor(Color(.systemBlue))
                    .cornerRadius(32)
                    .padding(.leading, 25)
                // friend's name
                Text(user.fullname.capitalized)
                    .fontWeight(.bold)
                    .padding(.leading, 15)
                Spacer()
                Button(action: {}) {
                    Image(systemName: "ellipsis")
                        .rotationEffect(.degrees(90))
                        .padding(.trailing, 25)
                        .foregroundColor(.black)
                }
            }
            .foregroundColor(.black)
            .padding(.bottom, 25)
        }
    }
}

//struct FriendCard_Previews: PreviewProvider {
//    static var previews: some View {
//        FriendCard(name: "String")
//    }
//}
