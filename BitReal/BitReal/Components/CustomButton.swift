//
//  Button.swift
//  BitReal
//
//  Created by Ali Al-Adhami on 2/27/23.
//

import SwiftUI

struct CustomButton: View {
    var color: Color
    var bgColor: Color?
    var outline: Bool
    var label: String
    
    var body: some View {
        if (outline) {
            Text(label)
                .frame(width: 160, height: 50)
                .foregroundColor(color)
                .background(bgColor != nil ? bgColor : Color("Purple"))
                .cornerRadius(10)
        } else {
            Text(label)
                .frame(width: 160, height: 50)
                .foregroundColor(Color("Purple"))
                .background(bgColor != nil ? bgColor : .white)
                .cornerRadius(10)
        }
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(color: .white, outline: true, label: "Register")
    }
}
