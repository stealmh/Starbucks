//
//  RecommendCoffee.swift
//  Starbucks
//
//  Created by mino on 2023/11/15.
//

import IdentifiedCollections
import Foundation

struct RecommendCoffee: Equatable, Identifiable {
    let id: UUID
    let title: String
    let coffeeImage: String
}

extension RecommendCoffee {
    static let mock: IdentifiedArrayOf<RecommendCoffee> = [RecommendCoffee(id: UUID(), title: "아이스 아메리카노", coffeeImage: "food"),
                       RecommendCoffee(id: UUID(), title: "아이스 뭐라카노", coffeeImage: "food"),
                       RecommendCoffee(id: UUID(), title: "아이스 디카페인 카페 아메리카노", coffeeImage: "food")]
}
