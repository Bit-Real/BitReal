//
//  CreateHabitPage.swift
//  BitReal
//
//  Created by Don Nguyen on 3/2/23.
//

import SwiftUI
import FirebaseAuth

struct CreateHabitPage: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var model = HabitViewModel()
    @State private var habitName = ""
    @State private var description = ""
    @State private var freq = 0
    @State private var alarm = ""
    @State private var isOn = false
    
    var body: some View {
        VStack {
            TextField("Habit Name", text: $habitName)
                .padding()
                .frame(width: 350)
                .background(Color.white.opacity(01))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black))
                .padding(.top, 25)
            
            TextField("Description", text: $description)
                .padding()
                .frame(width: 350)
                .background(Color.white.opacity(0.1))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black))
                .padding(.top, 20)
            
            TextField("Frequency", value: $freq, formatter: NumberFormatter())
                .keyboardType(.numberPad)
                .padding()
                .frame(width: 350)
                .background(Color.white.opacity(0.1))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black))
                .padding(.top, 20)
            
            TextField("Alarm", text: $alarm)
                .padding()
                .frame(width: 350)
                .background(Color.white.opacity(0.1))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black))
                .padding(.top, 20)
            
            HStack {
                Toggle("Private to friends", isOn: $isOn)
                    .toggleStyle(SwitchToggleStyle(tint: .purple))
                    .padding(.leading, 17)
                    .padding(.trailing, 20)
            }
            .padding()
            
            Button {
                let progress = Array(repeating: false, count: 7)
                model.addData(uid: String(Auth.auth().currentUser!.uid),
                              name: habitName,
                              description: description,
                              frequency: freq,
                              alarm: alarm,
                              privacy: isOn,
                              streak: 0,
                              progress: progress)
                // reset @State variables after a new habit is created
                habitName = ""
                description = ""
                freq = 0
                alarm = ""
                isOn = false
                presentationMode.wrappedValue.dismiss()
            } label: {
                HStack {
                    Image(systemName: "plus")
                        .foregroundColor(Color.purple)
                    Text("Create Habit")
                }
                .frame(width: 125, height: 5)
                .foregroundColor(Color.purple)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(.purple, lineWidth: 2)
                )
            }
            .padding()
            Spacer()
        }
        .navigationTitle("New Habit")
    }
}

struct CreateHabitPage_Previews: PreviewProvider {
    static var previews: some View {
        CreateHabitPage()
    }
}
