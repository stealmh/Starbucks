//
//  Card.swift
//  Starbucks
//
//  Created by DEV IOS on 2023/12/08.
//

import IdentifiedCollections
import Foundation

struct Card: Hashable, Identifiable {
    let id = UUID()
    let cardName: String
    let cardNumber: String
    let cardImage: String
    let money: Int
    var isHighlight: Bool
}
//MARK: - Mock
extension Card {
    static let mock: IdentifiedArrayOf<Card> = [Card(cardName: "스타벅스 e카드(276347)",
                                                     cardNumber:"1232-3256-2322-4441",
                                                     cardImage: "cookie",
                                                     money: 30231230,
                                                     isHighlight: true),
                                                Card(cardName: "스타벅스 그린 워드마크 카드(041926)",
                                                     cardNumber: "5611-2512-3321-6312",
                                                     cardImage: "pizza",
                                                     money: 0,
                                                     isHighlight: false)]
}
