//
//  Navbar.swift
//  BitReal
//
//  Created by Ali Al-Adhami on 2/23/23.
//

import SwiftUI

struct Navbar: View {
    
    @State var selectedIndex = 0
    
    let navSFSymbols = ["house", "person.2", "checklist", "person.crop.circle"]
    let tabText = ["Home", "Friends", "Habits", "Profile"]
    
    var body: some View {
        VStack {
            ZStack {
                switch selectedIndex {
                case 0:
                    HomePage()
                case 1:
                    FriendsPage()
                case 2:
                    HabitsPage()
                case 3:
                    ProfilePage()
                default:
                    HomePage()
                }
            }
            Divider()
            HStack {
                ForEach(0..<4, id: \.self) { number in
                    Spacer()
                    VStack {
                        Button(action: {
                            self.selectedIndex = number
                        }, label: {
                            Image(systemName: navSFSymbols[number])
                                .font(.system(size: 25, weight: .regular, design: .default))
                                .foregroundColor(selectedIndex == number ? .black : Color(UIColor.lightGray))
                        })
                        Text(tabText[number])
                            .font(.system(size: 12, weight: selectedIndex == number ? .bold : .regular))
                            .foregroundColor(selectedIndex == number ? .black : Color(UIColor.lightGray))
                            .padding(.top, 2)
                    }
                    Spacer()
                }
            }
        }
    }
}
