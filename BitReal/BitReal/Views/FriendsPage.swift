//
//  FriendsPage.swift
//  BitReal
//
//  Created by Ali Al-Adhami on 2/23/23.
//

import SwiftUI
import Firebase

struct FriendsPage: View {
//    @EnvironmentObject var viewModel: AuthViewModel
    @ObservedObject var viewModel = FriendsSearchModel()
    private var friendsList = ["casper",
                               "casper the ghost",
                               "not casper the ghost",
                               "who am I?",
                               "I got no name",
                               "Boo!",
                               "not scared, huh?",
                               "BitReal, more like bitUnreal" ]
    
//    @State private var friendsArray = [String]()
//    Firestore.firestore().collection("users").document(viewModel.currentUser?.id)
    
    @State var searchText = ""
    var body: some View {
//        if let user = viewModel.currentUser {
            NavigationView {
                ZStack {
                    ScrollView {
                        LazyVStack {
                            ForEach(friends, id: \.self) { friend in
                                FriendCard(name: friend.capitalized)
                            }
                        }
                        .searchable(text: $searchText)
                    }
                    .navigationTitle("My Friends")
                    Group {
                        AddButton()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                    .padding()
                    .padding(.trailing, 10)
                }
            }
            .navigationBarBackButtonHidden()
//        }
    }
    var friends: [String] {
            let friendsLC = friendsList.map { $0.lowercased() }
            return searchText == "" ? friendsLC : friendsLC.filter {
                $0.contains(searchText.lowercased())
            }
        }
    
    // filtering method, takes in friends array, lower case it
    // and search the array beased on the searchText state variable

//    var friends: [String] {
//        var friendsArray = [String]()
//        Firestore.firestore().collection("users").document((viewModel.currentUser?.id)!).getDocument { (document, error) in
//            if let document = document, document.exists {
//                guard let data = document.data(),
//                      let friendsArr = data["friends"] as? [String] else {
//                    print("Error: could not extract friends array from document data")
//                    return
//                }
//                let friendsLC = friendsArr.map { $0.lowercased() }
//                print("FriendsLC: \(friendsLC)") // Do something with the friends array
//                friendsArray = Array(friendsLC)
//            } else {
//                print("Error: could not retrieve document or document does not exist")
//            }
//        }
//        //let friendsLC = friendsArray.map { $0.lowercased() }
//        print("FriendsArr: \(friendsArray)")
//        return searchText == "" ? friendsArray : friendsArray.filter {
//            $0.contains(searchText.lowercased())
//        }
//    }
    
//    func getFriends(completion: @escaping ([String]) -> Void) {
//        Firestore.firestore().collection("users").document((viewModel.currentUser?.id)!).getDocument { (document, error) in
//            if let document = document, document.exists {
//                guard let data = document.data(),
//                      let friendsArr = data["friends"] as? [String] else {
//                    print("Error: could not extract friends array from document data")
//                    completion([])
//                    return
//                }
//                let friendsLC = friendsArr.map { $0.lowercased() }
//                //print("FriendsLC: \(friendsLC)") // Do something with the friends array
//                completion(friendsLC)
//            } else {
//                print("Error: could not retrieve document or document does not exist")
//                completion([])
//            }
//        }
//    }
//
//    var friends: [String] {
//        var friendsArray = [String]()
//        getFriends { friendsList in
//            friendsArray = friendsList
//            print("FriendsArr: \(friendsArray)")
//        }
//        print("Before search: \(friendsArray)")
//        return searchText == "" ? friendsArray : friendsArray.filter {
//            $0.contains(searchText.lowercased())
//        }
//    }
    
//    func getFriends(completion: @escaping ([String]) -> Void) {
//        Firestore.firestore().collection("users").document((viewModel.currentUser?.id)!).getDocument { (document, error) in
//            if let document = document, document.exists {
//                guard let data = document.data(),
//                      let friendsArr = data["friends"] as? [String] else {
//                    print("Error: could not extract friends array from document data")
//                    completion([])
//                    return
//                }
//                let friendsLC = friendsArr.map { $0.lowercased() }
//                //print("FriendsLC: \(friendsLC)") // Do something with the friends array
//                completion(friendsLC)
//            } else {
//                print("Error: could not retrieve document or document does not exist")
//                completion([])
//            }
//        }
//    }
//
//    var friends: [String] {
//        get {
//            var filteredFriends = [String]()
//            getFriends { friendsList in
//                filteredFriends = searchText == "" ? friendsList : friendsList.filter {
//                    $0.contains(searchText.lowercased())
//                }
//            }
//            print(filteredFriends)
//            return filteredFriends
//        }
//    }


}

//func retrieveFriends() -> [String] {
//    Firestore.firestore().collection("users").document(viewModel.currentUser?.id)
//}

struct FriendsPage_Previews: PreviewProvider {
    static var previews: some View {
        FriendsPage()
    }
}

