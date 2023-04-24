//
//  RoundedShape.swift
//  BitReal
//
//  Created by Ali Al-Adhami on 4/3/23.
//

import SwiftUI

// round shape used in image selector and habit public view page
struct RoundedShape: Shape {
    var corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: 80, height: 80))
        return Path(path.cgPath)
    }
}
