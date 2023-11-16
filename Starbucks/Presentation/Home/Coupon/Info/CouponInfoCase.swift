//
//  CouponInfoCase.swift
//  Starbucks
//
//  Created by DEV IOS on 2023/11/16.
//

import SwiftUI

enum PreNextButtonType {
    case previous
    case next
}

enum InfoPaging: CaseIterable {
    case person
    case house
    case circle
    case square
    
    var color: Color {
        switch self {
        case .person: return .red
        case .house: return .orange
        case .circle: return .yellow
        case .square: return .green
        }
    }
}
