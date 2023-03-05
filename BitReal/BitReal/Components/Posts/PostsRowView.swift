//
//  PostsRowView.swift
//  BitReal
//
//  Created by Ali Al-Adhami on 2/24/23.
//

import SwiftUI

struct PostsRowView: View {
    var body: some View {
        // profile image, user info, and post
        VStack (alignment: .leading) {
            HStack (alignment: .top, spacing: 12) {
                // user image
                Image("casperImg")
                    .resizable()
                    .frame(width: 56, height: 56)
                    .foregroundColor(Color(.systemBlue))
                    .cornerRadius(30)
                VStack (alignment: .leading) {
                    HStack {
                        // public name
                        Text("Casper")
                            .font(.subheadline).bold()
                        // username
                        Text("@casper420")
                            .foregroundColor(Color("gray"))
                            .font(.caption)
                        // how long since posted
                        Text("5d")
                            .foregroundColor(Color("gray"))
                            .font(.caption)
                    }
                    // post content
                    Text("I woke up at 7 A.M. today!!!")
                        .font(.body)
                        .multilineTextAlignment(.leading)
                }
            }
            // like and comment buttons
            HStack {
                Spacer()
                Button (action: {}) {
                    Image(systemName: "face.smiling")
                        .font(.system(size: 20))
                        .foregroundColor(.gray)
                }
                Button (action: {}) {
                    Image(systemName: "text.bubble")
                        .font(.system(size: 20))
                        .foregroundColor(.gray)
                }
            }
            .padding(.trailing, 15)
            .padding(.bottom, 5)
            Divider()
        }
        .padding()
    }
}

struct PostsRowView_Previews: PreviewProvider {
    static var previews: some View {
        PostsRowView()
    }
}
