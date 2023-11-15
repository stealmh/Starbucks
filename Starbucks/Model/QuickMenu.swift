//
//  QuickMenu.swift
//  Starbucks
//
//  Created by mino on 2023/10/25.
//

import Foundation

struct QuickMenu: Identifiable {
    let id = UUID()
    let image: String
    let title: String
}

//MARK: - Mock
extension QuickMenu {
    static let mock: [QuickMenu] = [QuickMenu(image: "star", title: "별 히스토리"),
                                    QuickMenu(image: "star", title: "전자영수증"),
                                    QuickMenu(image: "", title: ""),
                                    QuickMenu(image: "star", title: "개인정보 관리"),
                                    QuickMenu(image: "star", title: "계정정보"),
                                    QuickMenu(image: "star", title: "나만의 메뉴")]
}
