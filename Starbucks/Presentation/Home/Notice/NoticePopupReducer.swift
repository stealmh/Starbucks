//
//  NoticePopupReducer.swift
//  Starbucks
//
//  Created by DEV IOS on 2023/11/21.
//

import ComposableArchitecture
import Foundation

struct NoticePopupReducer: Reducer {
    struct State: Equatable {
        var style: PopupStyle = .review
    }
    
    enum Action: Equatable {
        case dismiss
        case deleteMessage
        case writeReview
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .dismiss:
                return .none
            case .deleteMessage:
                return .none
            case .writeReview:
                return .none
            }
        }
    }
}
