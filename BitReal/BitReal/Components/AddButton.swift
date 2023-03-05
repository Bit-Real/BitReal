//
//  AddButton.swift
//  BitReal
//
//  Created by Ali Al-Adhami on 3/4/23.
//

import SwiftUI

struct AddButton: View {
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.purple, lineWidth: 2)
                .background(Circle().foregroundColor(.white))
            Image(systemName: "plus")
                .font(.system(size: 25))
                .foregroundColor(Color.purple)
        }
        .frame(width: 64, height: 64)
    }
}

struct AddButton_Previews: PreviewProvider {
    static var previews: some View {
        AddButton()
    }
}
