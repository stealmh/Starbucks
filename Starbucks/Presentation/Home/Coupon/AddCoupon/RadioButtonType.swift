//
//  RadioButtonType.swift
//  Starbucks
//
//  Created by mino on 2023/10/25.
//

import Foundation

enum RadioButtonType: CaseIterable {
    case recipe
    case mms
    case star
    
    var title: String {
        switch self {
        case .recipe: return "영수증 쿠폰"
        case .mms: return "MMS 쿠폰"
        case .star: return "Star 쿠폰"
        }
    }
}
