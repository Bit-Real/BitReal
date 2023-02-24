//
//  HomePage.swift
//  BitReal
//
//  Created by Ali Al-Adhami on 2/23/23.
//

import SwiftUI

struct HomePage: View {
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
    }
}
