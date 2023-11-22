//
//  NoticeCase.swift
//  Starbucks
//
//  Created by mino on 2023/11/15.
//

import Foundation

enum NoticeImageCase: CaseIterable {
    case menuReady
    case review
    
    var imageName: String {
        switch self {
        case .menuReady: return "popcorn"
        case .review: return "star"
        }
    }
}

enum NoticeCase: SqaureBoxLayer, CaseIterable {
    case all
    case promotionEvent
    case couponAlert
    case presentAlert
    case sirenOrderAlert
    case cardChargeAlert
    case systemNotice
    
    var title: String {
        switch self {
        case .all: return "전체"
        case .promotionEvent: return "프로모션/이벤트"
        case .couponAlert: return "쿠폰 알림"
        case .presentAlert: return "선물 알림"
        case .sirenOrderAlert: return "사이렌 오더 알림"
        case .cardChargeAlert: return "카드 충전 알림"
        case .systemNotice: return "시스템 공지"
        }
    }
}
