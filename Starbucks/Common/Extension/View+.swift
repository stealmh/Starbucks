//
//  View+.swift
//  Starbucks
//
//  Created by mino on 2023/11/15.
//

import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
    
    /// Color를 넣기위한 목적의 ZStack
    @ViewBuilder
    func embedInZStackForColor(_ color: Color, _ opacity: Double) -> some View {
        ZStack {
            color.opacity(opacity)
            self
        }
    }
    /// popover를 할 때 애니메이션효과를 끔
    func withoutAnimation(action: @escaping () -> Void) {
        var transaction = Transaction()
        transaction.disablesAnimations = true
        withTransaction(transaction) {
            action()
        }
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

extension View {
}
