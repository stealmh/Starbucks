//
//  CouponCase.swift
//  Starbucks
//
//  Created by mino on 2023/10/25.
//

import Foundation

enum CouponCase {
    case usableCoupon
    case couponHistory
    
    var title: String {
        switch self {
        case .usableCoupon: return "사용 가능한 쿠폰"
        case .couponHistory: return "쿠폰 히스토리"
        }
    }
}
