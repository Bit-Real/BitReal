//
//  FriendsPage.swift
//  BitReal
//
//  Created by Ali Al-Adhami on 2/23/23.
//

import SwiftUI

struct FriendsPage: View {
    private var friendsList = ["casper",
                               "casper the ghost",
                               "not casper the ghost",
                               "who am I?",
                               "I got no name",
                               "Boo!",
                               "not scared, huh?",
                               "BitReal, more like bitUnreal" ]
    @State var searchText = ""
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(friends, id: \.self) { friend in
                        FriendCard(name: friend.capitalized)
                    }
                }
                .searchable(text: $searchText)
            }
            .navigationTitle("My Friends")
        }
    }
    
    // filtering method, takes in friends array, lower case it
    // and search the array beased on the searchText state variables
    var friends: [String] {
        let friendsLC = friendsList.map { $0.lowercased() }
        return searchText == "" ? friendsLC : friendsLC.filter {
            $0.contains(searchText.lowercased())
        }
    }
}

struct FriendsPage_Previews: PreviewProvider {
    static var previews: some View {
        FriendsPage()
    }
}

