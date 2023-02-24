//
//  FriendsPage.swift
//  BitReal
//
//  Created by Ali Al-Adhami on 2/23/23.
//

import SwiftUI

struct FriendsPage: View {
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    SearchBar()
                    ForEach(0 ... 25, id: \.self) { _ in
                        FriendCard()
                    }
                }
            }
            .navigationTitle("My Friends")
        }
    }
}

struct FriendsPage_Previews: PreviewProvider {
    static var previews: some View {
        FriendsPage()
    }
}

