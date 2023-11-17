//
//  OrderModel.swift
//  Starbucks
//
//  Created by mino on 2023/11/16.
//

import Foundation

struct Order: Identifiable {
    let id = UUID()
    let image: String
    let title: String
    let subTitle: String?
    let detail: [OrderDetail]
}

struct OrderDetail: Identifiable {
    let id = UUID()
    let image: String
    let title: String
    let enTitle: String
    let price: Int
}

extension Order {
    static let mock = [Order(image: "star", title: "Trenta", subTitle: nil,
                             detail: [OrderDetail(image: "star", title: "콜드 브루", enTitle: "Cold Brew", price: 6900),
                                      OrderDetail(image: "star", title: "아이스 자몽 허니 블랙 티", enTitle: "Iced Grapefruit Honey Black Tea", price: 7700),
                                      OrderDetail(image: "star", title: "딸기 아사이 레모네이드 스타벅스 리프레셔", enTitle: "DDal-gi", price: 7900)]),
                       Order(image: "star", title: "New", subTitle: nil,
                                                detail: [OrderDetail(image: "star", title: "콜드 브루", enTitle: "Cold Brew", price: 6900),
                                                         OrderDetail(image: "star", title: "아이스 자몽 허니 블랙 티", enTitle: "Iced Grapefruit Honey Black Tea", price: 7700),
                                                         OrderDetail(image: "star", title: "딸기 아사이 레모네이드 스타벅스 리프레셔", enTitle: "DDal-gi", price: 7900)])]
}
