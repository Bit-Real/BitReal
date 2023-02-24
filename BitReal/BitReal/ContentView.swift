//
//  ContentView.swift
//  BitReal
//
//  Created by Ali Al-Adhami on 2/22/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomePage()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            FriendsPage()
                .tabItem {
                    Image(systemName: "person.2")
                    Text("Friends")
                }
            
            HabitsPage()
                .tabItem {
                    Image(systemName: "checklist")
                    Text("Habits")
                    
                }
            
            ProfilePage()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Profile")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
