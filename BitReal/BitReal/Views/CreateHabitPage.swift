//
//  CreateHabitPage.swift
//  BitReal
//
//  Created by Don Nguyen on 3/2/23.
//

import SwiftUI

struct CreateHabitPage: View {
    @State private var habitName = ""
    @State private var description = ""
    @State private var freq = ""
    @State private var alarm = ""
    @State private var privacy = ""
    var body: some View {
        VStack{
            Text("New Habit")
                .padding(.top, 50)
                .font(.system(size: 40))
                .fontWeight(.bold)
                .offset(x: -90, y: -90)
            TextField("Habit Name", text: $habitName)
                .padding()
                .frame(width: 350)
                .background(Color.white.opacity(01))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black))
                .offset(y: -145)
                .padding(.top, 30)
            
            TextField("Description", text: $description)
                .padding()
                .frame(width: 350)
                .background(Color.white.opacity(0.1))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black))
                .offset(y: -170)
                .padding(.top, 30)
            
            TextField("Frequency", text: $freq)
                .padding()
                .frame(width: 350)
                .background(Color.white.opacity(0.1))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black))
                .offset(y: -180)
                .padding(.top, 15)
            
            TextField("Alarm", text: $alarm)
                .padding()
                .frame(width: 350)
                .background(Color.white.opacity(0.1))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black))
                .offset(y: -190)
                .padding(.top, 15)
            
            SecureField("Private to Friends", text: $privacy)
                .padding()
                .frame(width: 350)
                .background(Color.white.opacity(0.1))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black))
                .offset(y: -200)
                .padding(.top, 15)
            
            Button(action: {}) {
                Text("Create Habit")
                    .frame(width: 100, height: 5)
                    .foregroundColor(Color.purple)
                    .padding()
                    .border(Color.purple, width: 2)
            }
            .offset(y: -150)
        }
    }
}

struct CreateHabitPage_Previews: PreviewProvider {
    static var previews: some View {
        CreateHabitPage()
    }
}
