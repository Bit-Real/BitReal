//
//  CustomNavBackButton.swift
//  BitReal
//
//  Created by Ali Al-Adhami on 4/13/23.
//

import Foundation
import SwiftUI

struct CustomBackButton: View {
    let color: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: "chevron.left")
                    .foregroundColor(color)
                Text("Home")
                    .foregroundColor(color)
                    .fontWeight(.semibold)
            }
        }
    }
}
