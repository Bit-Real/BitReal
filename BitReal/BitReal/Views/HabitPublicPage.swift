//
//  HabitPublicPage.swift
//  BitReal
//
//  Created by Ali Al-Adhami on 4/13/23.
//

import SwiftUI

struct HabitPublicPage: View {
    
    let habit: HabitModel
    let post: Post
    @Environment(\.presentationMode) var presentationMode
    
    init(habit: HabitModel, post: Post) {
        self.habit = habit
        self.post = post
        //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.red]

        //Use this if NavigationBarTitle is with displayMode = .inline
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.red]
    }
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 10) {
                HStack { Spacer() }
                
                customFontAndText(for: habit.name)
                
                HStack(spacing: 5) {
                    Text("by:")
                        .font(.subheadline)

                    Text("\(post.user?.fullname ?? "Null"),")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .italic()
                    
                    Text("@\(post.user?.username ?? "Null")")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(Color(uiColor: UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)))
                        .italic()
                }
            }
            .frame(height: 260)
            .padding(.leading)
            .background(Color("Purple"))
            .foregroundColor(.white)
            .clipShape(RoundedShape(corners: [.bottomRight]))
                        
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(.white)
                    .shadow(color: Color(uiColor: UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1)), radius: 30)
                VStack(alignment: .leading, spacing: 15) {
                    HStack {
                        Text("Description: \(habit.description)")
                    }
                    Text("Streak count: \(habit.streak)")
                    Text("Frequency: \(habit.frequency)")
                    Text("Created: \(Utility.convertTimestampToString(timestamp: habit.timestamp)) ago")
                    Spacer()
                }
                .padding(.leading, 25)
                .padding(.top, 25)
                
            }
            .frame(width: 350, height: 400)
            .padding(.top, 35)
            
            Spacer()
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButton(color: .white) {
            self.presentationMode.wrappedValue.dismiss()
        })
    }
    
    func customFontAndText(for text: String) -> some View {
        let characterCount = text.count
        
        if characterCount <= 15 {
            return Text(text)
                .font(.largeTitle)
                .fontWeight(.semibold)
        } else if characterCount <= 25 {
            return Text(text)
                .font(.title2)
                .fontWeight(.semibold)
        } else if characterCount <= 30 {
            return Text(text)
                .font(.title3)
                .fontWeight(.semibold)
        } else {
            return Text(Utility.truncateString(text, maxLength: 30))
                .font(.title3)
                .fontWeight(.semibold)
        }
    }

}

