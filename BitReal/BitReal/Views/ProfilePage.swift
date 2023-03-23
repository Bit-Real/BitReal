//
//  ProfilePage.swift
//  BitReal
//
//  Created by Ali Al-Adhami on 2/23/23.
//

import SwiftUI
import Kingfisher

struct ProfilePage: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    let settingsOptions = ["Change Password", "Notifications", "Themes"]
    
    var body: some View {
        if let user = viewModel.currentUser {
            NavigationView {
                ZStack {
                    VStack {
                        KFImage(URL(string: user.profileImageURL))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                            .padding()
                        
                        Text(user.fullname)
                            .bold()
                            .font(.system(size: 20))
                        
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
                        
                        Button {
                            viewModel.signout()
                        } label: {
                            Text("Sign Out")
                        }
                        .padding(.bottom, 10)

                    }
                }
                .navigationTitle("Profile")
            }
            .navigationBarBackButtonHidden()
        }
    }
}

struct ProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePage()
    }
}

