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
    let tabText = ["Home", "Follow", "Habits", "Profile"]
    
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
                                .font(.system(size: 25, weight: selectedIndex == number ? .bold : .regular, design: .default))
                                .foregroundColor(selectedIndex == number ? Color("Purple") : Color("gray"))
                                .frame(width: 80, height: 40)
                                .background(selectedIndex == number ? Color("navbarItemBG") : Color("navBG"))
                                .cornerRadius(32)
                        })
                        .padding(.top, 5)
                        
                        Text(tabText[number])
                            .font(.system(size: 12, weight: selectedIndex == number ? .bold : .regular))
                            .foregroundColor(selectedIndex == number ? .black : Color("navText"))
                            .padding(.top, 2)
                    }
                    Spacer()
                }
            }
            .background(Color("navBG"))
        }
    }
}
