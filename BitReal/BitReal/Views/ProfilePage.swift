//
//  ProfilePage.swift
//  BitReal
//
//  Created by Ali Al-Adhami on 2/23/23.
//

import SwiftUI
import Firebase
import FirebaseAuth
import Kingfisher

struct ProfilePage: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    let settingsOptions = ["Change Username", "Change Password", "Notifications"]
    @State var newUsername: String = ""
    @State var newPassword: String = ""
    
    var body: some View {
        if let user = viewModel.currentUser {
            NavigationStack {
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
                        
                        Text("@\(user.username)")
                            .font(.system(size: 15))
                            .foregroundColor(.gray)
                        
                        Divider()
                            .frame(height: 4)
                            .frame(width: 80)
                            .overlay(Color("Purple"))
                            .cornerRadius(10)
                            .padding(.bottom, 25)
                        
                        List(settingsOptions, id: \.self) { setting in
                            NavigationLink(setting) {
                                getSettingView(setting: setting)
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
    
    func getSettingView(setting: String) -> AnyView {
        if(setting == "Change Username") {
            return AnyView(ChangeUsernamePage())
        } else if (setting == "Change Password"){
            return AnyView (ChangePasswordPage())
        } else {
            return AnyView(EmptyView())
        }
    }
}

struct ProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePage()
    }
}

