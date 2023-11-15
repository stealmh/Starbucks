//
//  NoticeModel.swift
//  Starbucks
//
//  Created by mino on 2023/10/25.
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

struct NoticeModel: Identifiable {
    let id = UUID()
    let noticeType: NoticeImageCase
    let noticeTitle: String
    let noticeTime: String
    let myType: NoticeCase
    var detail: NoticeDetailModel?
}

struct NoticeDetailModel: Identifiable {
    let id = UUID()
    let noticeType: String
    let noticeTitle: String
    let noticeTime: String
    var isOpen: Bool
}

extension NoticeModel {
    static let mock = [
        NoticeModel(noticeType: .menuReady, noticeTitle: "이건프로모션", noticeTime: "456", myType: .promotionEvent, detail: NoticeDetailModel(noticeType: "1", noticeTitle: "1", noticeTime: "1", isOpen: false)),
        NoticeModel(noticeType: .review, noticeTitle: "카드충전띠", noticeTime: "456", myType: .cardChargeAlert, detail: NoticeDetailModel(noticeType: "1", noticeTitle: "1", noticeTime: "1", isOpen: false)),
        NoticeModel(noticeType: .menuReady, noticeTitle: "이건쿠폰", noticeTime: "456", myType: .couponAlert, detail: NoticeDetailModel(noticeType: "1", noticeTitle: "1", noticeTime: "1", isOpen: false)),
        NoticeModel(noticeType: .menuReady, noticeTitle: "이건쿠폰", noticeTime: "456", myType: .couponAlert, detail: nil)]
}
