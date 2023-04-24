//
//  HomePage.swift
//  BitReal
//
//  Created by Ali Al-Adhami on 2/23/23.
//

import SwiftUI
import Firebase

struct HomePage: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    @ObservedObject var feedViewModel = FeedViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(feedViewModel.posts, id: \.self) { post in
                        PostsRowView(post: post)
                    }
                }
            }
            .navigationTitle("Home")
        }
        .navigationBarBackButtonHidden()
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}

