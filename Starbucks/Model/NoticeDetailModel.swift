//
//  NoticeDetailModel.swift
//  Starbucks
//
//  Created by mino on 2023/11/15.
//

import Foundation

struct NoticeDetailModel: Identifiable {
    let id = UUID()
    let noticeType: String
    let noticeTitle: String
    let noticeTime: String
    var isOpen: Bool
}
