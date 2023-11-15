//
//  WhatsNewCase.swift
//  Starbucks
//
//  Created by mino on 2023/10/25.
//

import Foundation

protocol SqaureBoxLayer {
    var title: String { get }
}

extension WhatsNewView {
    enum MenuCase: SqaureBoxLayer, CaseIterable {
        case all
        case eventAndNews
        case notice
        
        var title: String {
            switch self {
            case .all:          return "전체"
            case .eventAndNews: return "이벤트&뉴스"
            case .notice:       return "공지사항"
            }
        }
    }
}

