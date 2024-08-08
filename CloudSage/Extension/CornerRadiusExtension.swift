//
//  CornerRadiusExtension.swift
//  CloudSage
//
//  Created by Jin Lee on 8/6/24.
//

// 사각형의 꼭짓점을 각각 둥글게 할 수 있는 익스텐션
import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        
        return Path(path.cgPath)
    }
}
