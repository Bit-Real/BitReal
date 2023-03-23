//
//  FriendProfilePage.swift
//  BitReal
//
//  Created by Ali Al-Adhami on 3/23/23.
//

import SwiftUI
import Kingfisher

struct FriendProfilePage: View {
    
    @State var segCtrlSelection: ProfileSelection = .activities
    let user: User
    
    enum ProfileSelection: String, CaseIterable {
        case activities = "Activities"
        case habits = "Habits"
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                LazyVStack {
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
                    
                    Picker("", selection: $segCtrlSelection) {
                        ForEach(ProfileSelection.allCases, id: \.self) { option in
                            Text(option.rawValue)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    
                    if (segCtrlSelection == ProfileSelection.activities) {
                        Text("Activity")
                    } else {
                        Text("Habits")
                    }
                    
                    Spacer()
                }
            }
        }
    }
}

struct FriendProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        FriendProfilePage(user: User(email: "mike@yahoo.com",
                                     username: "mike",
                                     fullname: "Michael Weston",
                                     friends: ["Alex Miller", "Fi"],
                                     profileImageURL: "https://images.unsplash.com/photo-1605646840343-87ea1843fcbc?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80"))
    }
}
