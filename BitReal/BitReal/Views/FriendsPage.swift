//
//  FriendsPage.swift
//  BitReal
//
//  Created by Ali Al-Adhami on 2/23/23.
//

import SwiftUI
import Firebase

struct FriendsPage: View {
//    @EnvironmentObject var viewModel: AuthViewModel
    @ObservedObject var viewModel = FriendsSearchModel()
    private var friendsList = ["casper",
                               "casper the ghost",
                               "not casper the ghost",
                               "who am I?",
                               "I got no name",
                               "Boo!",
                               "not scared, huh?",
                               "BitReal, more like bitUnreal" ]
    
//    @State var searchText = ""
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.searchableUsers, id: \.self) { friend in
                            FriendCard(user: friend)
                        }
                    }
                    .searchable(text: $viewModel.searchText)
                }
                .navigationTitle("My Friends")
                Group {
                    AddButton()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                .padding()
                .padding(.trailing, 10)
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

