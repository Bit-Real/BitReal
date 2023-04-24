//
//  FriendProfilePage.swift
//  BitReal
//
//  Created by Ali Al-Adhami on 3/23/23.
//

import SwiftUI
import Kingfisher
import Firebase

struct FriendProfilePage: View {
    
    @ObservedObject var notification = NotificationViewModel()
    @ObservedObject var viewModel: FriendProfileViewModel
    @ObservedObject var friendViewModel: FriendsSearchModel
    
    @State var segCtrlSelection: ProfileSelection = .activities
    
    enum ProfileSelection: String, CaseIterable {
        case activities = "Activities"
        case habits = "Habits"
    }
    
    init(user: User, friendViewModel: FriendsSearchModel) {
        self.viewModel = FriendProfileViewModel(user: user)
        self.friendViewModel = friendViewModel
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
                            let userToRemoveID = viewModel.user.id
                            let filteredUsers = friendViewModel.users.filter { $0.id != userToRemoveID }
                            friendViewModel.users = filteredUsers
                        } else {
                            viewModel.beFriends()
                            notification.addFollowNotification(followedUserID: viewModel.user.id!, followedUserName: viewModel.user.username)
                        }
                    } label: {
                        Text(viewModel.user.isFriend ?? false ? "Unfollow" : "Follow")
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
                        if (viewModel.posts.isEmpty) {
                            Text("@\(viewModel.user.username) has not posted anything yet")
                                .foregroundColor(.gray)
                                .padding(.top, 10)
                        } else {
                            ForEach(viewModel.posts) { post in
                                PostsRowView(post: post)
                            }
                        }
                        
                    } else {
                        if (viewModel.habits.isEmpty) {
                            Text("No habits to show!")
                                .foregroundColor(.gray)
                        } else {
                            ForEach(viewModel.habits) { habit in
                                HabitCard(habit: habit, habitColor: Color(hex: habit.habitColor))
                            }
                        }
                    }
                    
                    Spacer()
                }
            }
        }
    }
}
