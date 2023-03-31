//
//  HabitExpand.swift
//  BitReal
//
//  Created by Pinru Chen on 3/30/23.
//

import SwiftUI

struct HabitExpand: View {
    var description: String
    var habitColor: Color
    
    var body: some View {
        VStack {
            HStack {
                Text(description)
                    .font(.system(size: 15))
                    .padding()
                Spacer()
            }
            HStack {
                ZStack {
                    Color("cardGray")
                    HStack {
                        Image(systemName: "plus.circle")
                            .foregroundColor(habitColor)
                        Button(action: {}) {
                            Text("Done!")
                                .fontWeight(.medium)
                        }
                        .foregroundColor(habitColor)
                        .padding(.leading, -5)
                    }
                    HStack {
                        Spacer()
                        Button(action: {}) {
                            Image(systemName: "arrow.down.circle")
                        }
                        .foregroundColor(habitColor)
                        .padding(.trailing, 10)
                    }
                }
            }
            .cornerRadius(10, corners: [.bottomLeft, .bottomRight])
        }
        .frame(width: 350, height: 96)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 1)
        )
    }
}

// Used to specify which corner to round
struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct HabitExpand_Previews: PreviewProvider {
    static var previews: some View {
        HabitExpand(description: "Test desc", habitColor: .red)
    }
}
