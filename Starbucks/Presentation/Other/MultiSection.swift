//
//  MultiSection.swift
//  Starbucks
//
//  Created by mino on 2023/10/25.
//

import Foundation

struct MultiSection: Identifiable {
    let id = UUID()
    let section: MultiSectionCase
    let detail: [SectionDetail]
}

struct SectionDetail: Identifiable {
    let id = UUID()
    let image: String
    let contentLabel: String
}

// MARK: - Case
extension MultiSection {
    enum MultiSectionCase {
        case pay
        case order
        
        var title: String {
            switch self {
            case .pay: return "Pay"
            case .order: return "Order"
            }
        }
    }
}

// MARK: - Mock
extension MultiSection {
    static let mock: [MultiSection] = [
        MultiSection(section: .pay, detail: [SectionDetail(image: "star", contentLabel: "스타벅스 카드 등록"),
                                             SectionDetail(image: "star", contentLabel: "카드 교환권 등록"),
                                             SectionDetail(image: "star", contentLabel: "쿠폰 등록"),
                                             SectionDetail(image: "star", contentLabel: "쿠폰 히스토리")]),
        MultiSection(section: .order, detail: [SectionDetail(image: "star", contentLabel: "장바구니"),
                                               SectionDetail(image: "star", contentLabel: "홀케이크 예약"),
                                               SectionDetail(image: "star", contentLabel: "히스토리")])
    ]
}
