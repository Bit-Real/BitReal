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
    
    func getSettingView(setting: String) -> some View {
        let db = Firestore.firestore()
        let ref = db.collection("users")
        let user = Auth.auth().currentUser
        let userID = user?.uid
        
        if(setting == "Change Username") {
            return VStack {
                Spacer()
                
                Text("New Username")
                    .font(.system(size: 32, weight: .bold))
                    .padding(.top, 50)
                
                TextField("Enter New Username", text: $newUsername)
                    .padding()
                    .background(Color.gray.opacity(0.3).cornerRadius(20))
                
                Button {
                    if(newUsername != "") {
                        ref.document(userID!).updateData(["username": newUsername]) { error in
                            if let error = error {
                                print("Error updating username: \(error.localizedDescription)")
                            } else {
                                viewModel.fetchUser()
                                print("Username updated successfully")
                            }
                        }
                    }
                } label: {
                    Text("Save")
                        .padding()
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.cornerRadius(20))
                        .foregroundColor(.white)
                }

                Spacer()
                Spacer()
            } .padding(.horizontal)
        } else {
            return VStack {
                Spacer()
                
                Text("New Password")
                    .font(.system(size: 32, weight: .bold))
                    .padding(.top, 50)
                
                TextField("Password (must be > 6 characters)", text: $newPassword)
                    .padding()
                    .background(Color.gray.opacity(0.3).cornerRadius(20))
                
                Button {
                    if(newPassword != "") {
                        user?.updatePassword(to: newPassword, completion: { error in
                            if let error = error {
                                print("Error updating password: \(error.localizedDescription)")
                            } else {
                                print("Password updated successfully")
                            }
                        })
                    }
                } label: {
                    Text("Save")
                        .padding()
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.cornerRadius(20))
                        .foregroundColor(.white)
                }

                Spacer()
                Spacer()
            } .padding(.horizontal)
        }
    }
}

struct ProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePage()
    }
}

