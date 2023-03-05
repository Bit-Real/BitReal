//
//  ProfilePage.swift
//  BitReal
//
//  Created by Ali Al-Adhami on 2/23/23.
//

import SwiftUI

struct ProfilePage: View {
    let settingsOptions = ["Change Password", "Notifications", "Themes"]
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Image("dogImage")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                        .padding()
                    
                    Text("Mr. Woofington")
                        .bold()
                    
                    Divider()
                        .frame(height: 4)
                        .frame(width: 80)
                        .overlay(Color("Purple"))
                        .padding(.bottom, 25)
                    
                    List(settingsOptions, id: \.self) { setting in
                        HStack {
                            Text(setting)
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        .listRowSeparator(.hidden)
                    } .listStyle(.plain)
                }
            }
            .navigationTitle("Profile")
        }
        .navigationBarBackButtonHidden()
    }
}

struct ProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePage()
    }
}

