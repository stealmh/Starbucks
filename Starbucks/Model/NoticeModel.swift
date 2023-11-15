//
//  NoticeModel.swift
//  Starbucks
//
//  Created by mino on 2023/10/25.
//

import Foundation

struct NoticeModel: Identifiable {
    let id = UUID()
    let noticeType: NoticeImageCase
    let noticeTitle: String
    let noticeTime: String
    let myType: NoticeCase
    var detail: NoticeDetailModel?
}

extension NoticeModel {
    static let mock = [
        NoticeModel(noticeType: .menuReady, noticeTitle: "이건프로모션", noticeTime: "456", myType: .promotionEvent, detail: NoticeDetailModel(noticeType: "1", noticeTitle: "1", noticeTime: "1", isOpen: false)),
        NoticeModel(noticeType: .review, noticeTitle: "카드충전띠", noticeTime: "456", myType: .cardChargeAlert, detail: NoticeDetailModel(noticeType: "1", noticeTitle: "1", noticeTime: "1", isOpen: false)),
        NoticeModel(noticeType: .menuReady, noticeTitle: "이건쿠폰", noticeTime: "456", myType: .couponAlert, detail: NoticeDetailModel(noticeType: "1", noticeTitle: "1", noticeTime: "1", isOpen: false)),
        NoticeModel(noticeType: .menuReady, noticeTitle: "이건쿠폰", noticeTime: "456", myType: .couponAlert, detail: nil)]
}
