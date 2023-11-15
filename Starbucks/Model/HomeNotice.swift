//
//  Notice.swift
//  Starbucks
//
//  Created by mino on 2023/11/15.
//

import Foundation

struct HomeNotice: Hashable {
    let id = UUID()
    let title: String
    let contents: String
    let thumbnail: String
}

extension HomeNotice {
    static let mock = [HomeNotice(title: "탄소중립포인트제 본인인증 고객대상 인센티브 지급 일정 안내",
                              contents: "23년 7월부터는 본인인증 완료 고객 대상 인센티브 지급 일정 안내드립니다.",
                              thumbnail: "food"),
                       HomeNotice(title: "탄소중립어쩌구저쩌",
                              contents: "23년 7월부터는 본인인증 완료 고객 대상 인센티브 지급 일정 안내드립니다.",
                              thumbnail: "pizza"),
                       HomeNotice(title: "탄소중립어쩌구구",
                               contents: "23년 7월부터는 본인인증 완료 고객 대상 인센티브 지급 일정 안내드립니다.",
                               thumbnail: "fries")]
}
