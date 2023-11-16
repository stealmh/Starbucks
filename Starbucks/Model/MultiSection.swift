//
//  MultiSection.swift
//  Starbucks
//
//  Created by mino on 2023/11/15.
//

import Foundation

struct MultiSection: Identifiable {
    let id = UUID()
    let section: MultiSectionCase
    let detail: [SectionDetail]
}
// MARK: - Case
extension MultiSection {
    enum MultiSectionCase {
        case pay
        case order
        case shop
        case delivers
        case customerSupport
        
        var title: String {
            switch self {
            case .pay: return "Pay"
            case .order: return "Order"
            case .shop: return "Shop"
            case .delivers: return "Delivers"
            case .customerSupport: return "고객지원"
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
                                               SectionDetail(image: "star", contentLabel: "히스토리")]),
        MultiSection(section: .shop, detail: [SectionDetail(image: "star", contentLabel: "온라인 스토어 주문내역"),
                                              SectionDetail(image: "star", contentLabel: "e-Gift Item 선물함"),
                                              SectionDetail(image: "star", contentLabel: "e-Gift Card 선물내역")]),
        MultiSection(section: .delivers, detail: [SectionDetail(image: "star", contentLabel: "주문하기"),
                                                  SectionDetail(image: "star", contentLabel: "장바구니"),
                                                  SectionDetail(image: "star", contentLabel: "배달완료 히스토리"),
                                                  SectionDetail(image: "star", contentLabel: "단체 주문 배달")]),
        MultiSection(section: .customerSupport, detail: [SectionDetail(image: "star", contentLabel: "스토어 케어"),
                                                         SectionDetail(image: "star", contentLabel: "고객의 소리"),
                                                         SectionDetail(image: "star", contentLabel: "매장 정보"),
                                                         SectionDetail(image: "star", contentLabel: "반납기 정보"),
                                                         SectionDetail(image: "star", contentLabel: "마이 스타벅스 리뷰"),
                                                         SectionDetail(image: "star", contentLabel: "바리스타 채용")])
    ]
}
