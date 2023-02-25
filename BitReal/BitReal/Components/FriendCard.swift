//
//  FriendCard.swift
//  BitReal
//
//  Created by Ali Al-Adhami on 2/24/23.
//

import SwiftUI

struct FriendCard: View {
    
    let name: String
    
    var body: some View {
        HStack {
            // freind's image
            Image("casperImg")
                .resizable()
                .frame(width: 64, height: 64)
                .foregroundColor(Color(.systemBlue))
                .cornerRadius(32)
                .padding(.leading, 25)
            // friend's name
            Text(name)
                .fontWeight(.bold)
                .padding(.leading, 15)
            Spacer()
            Button {
                //
            } label: {
                Image(systemName: "ellipsis")
                    .rotationEffect(.degrees(90))
                    .padding(.trailing, 25)
                    .foregroundColor(.black)
            }
        }
        .padding(.bottom, 25)
    }
}

struct FriendCard_Previews: PreviewProvider {
    static var previews: some View {
        FriendCard(name: "String")
    }
}
