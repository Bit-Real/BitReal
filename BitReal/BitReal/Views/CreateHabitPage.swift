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
    @State private var alarm = Date()
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
            
            DatePicker("Alarm", selection: $alarm, displayedComponents: .hourAndMinute)
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
                              progress: progress,
                              habitColor: hexString(for: getRandomPastelColor()) ?? "000000")
                // reset @State variables after a new habit is created
                habitName = ""
                description = ""
                freq = 0
                alarm = Date()
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
    
    func getRandomPastelColor() -> Color {
        let colorSchemes = [Color("CandyPink"), Color("VistaBlue"), Color("SeaGreen"),
                            Color("DarkLavender"), Color("Crayola"), Color("Xanthous"),
                            Color("RussianViolet"), Color("LightSalmon"), Color("MetallicBlue"),
                            Color("Asparagus"), Color("PearlAqua"), Color("ImperialRed"),
                            Color("RainbowIndigo"), Color("Bittersweet"), Color("WintergreenDream")]
        return colorSchemes[Int(arc4random_uniform(UInt32(colorSchemes.count)))]
    }

    func hexString(for color: Color) -> String? {
        let uiColor = UIColor(color)

        // Get the red, green, and blue components of the color
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        // Convert the RGB components to a hexadecimal string
        let hexString = String(format: "%02X%02X%02X", Int(red * 255), Int(green * 255), Int(blue * 255))
        return hexString
    }
    
}

struct CreateHabitPage_Previews: PreviewProvider {
    static var previews: some View {
        CreateHabitPage()
    }
}
