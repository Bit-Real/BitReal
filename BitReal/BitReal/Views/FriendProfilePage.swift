//
//  FriendProfilePage.swift
//  BitReal
//
//  Created by Ali Al-Adhami on 3/23/23.
//

import SwiftUI
import Kingfisher

struct FriendProfilePage: View {
    
    @ObservedObject var viewModel: FriendProfileViewModel
    
    @State var segCtrlSelection: ProfileSelection = .activities
//    @State private var isFriend = false
//    let user: User
    
    enum ProfileSelection: String, CaseIterable {
        case activities = "Activities"
        case habits = "Habits"
    }
    
    init(user: User) {
        self.viewModel = FriendProfileViewModel(user: user)
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                LazyVStack {
                    KFImage(URL(string: viewModel.user.profileImageURL))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                    
                    Text(viewModel.user.fullname)
                        .bold()
                        .font(.system(size: 20))
                        .padding(.top, 5)
                    
                    Text("@\(viewModel.user.username)")
                        .font(.system(size: 15))
                        .foregroundColor(.gray)
                        .padding(.bottom, 5)
                    
                    Button {
                        if (viewModel.user.isFriend ?? false) {
                            viewModel.unfriend()
                        } else {
                            viewModel.beFriends()
                        }
                    } label: {
                        Text(viewModel.user.isFriend ?? false ? "Unfriend" : "Friend")
                            .padding(.horizontal, 20)
                            .padding(.vertical, 5)
                            .background(viewModel.user.isFriend ?? false ? Color("Purple") : .white)
                            .foregroundColor(viewModel.user.isFriend ?? false ? .white : Color("Purple"))
                            .clipShape(Capsule())
                            .overlay(
                                    Capsule()
                                        .stroke(viewModel.user.isFriend ?? false ? .clear : Color("Purple") , lineWidth: 2)
                                )
                    }
                    
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
                                     fullname: "Michael Westen",
                                     profileImageURL: "https://images.unsplash.com/photo-1605646840343-87ea1843fcbc?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80",
                                    isFriend: false))
    }
}
