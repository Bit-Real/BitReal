//
//  FriendsPage.swift
//  BitReal
//
//  Created by Ali Al-Adhami on 2/23/23.
//

import SwiftUI
import Firebase

struct FriendsPage: View {
    
    @ObservedObject var viewModel = FriendsSearchModel()

    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    LazyVStack {
                        if (viewModel.searchableUsers.isEmpty) {
                            VStack {
                                Text("You're not following anyone")
                                Spacer()
                                Text("Use the search bar to find other users")
                            }
                            .foregroundColor(.gray)
                            .padding(.top, 225)
                        } else {
                            ForEach(viewModel.searchableUsers, id: \.self) { friend in
                                FriendCard(user: friend)
                            }
                        }
                    }
                    .searchable(text: $viewModel.searchText)
                }
                .navigationTitle("Following")
            }
        }
        .navigationBarBackButtonHidden()
    }
}

struct FriendsPage_Previews: PreviewProvider {
    static var previews: some View {
        FriendsPage()
    }
}

