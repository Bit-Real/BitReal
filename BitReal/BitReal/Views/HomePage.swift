//
//  HomePage.swift
//  BitReal
//
//  Created by Ali Al-Adhami on 2/23/23.
//

import SwiftUI

struct HomePage: View {
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(0 ... 25, id: \.self) { _ in
                        PostsRowView()
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

