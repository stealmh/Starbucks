//
//  CouponHistoryReducer.swift
//  Starbucks
//
//  Created by DEV IOS on 2023/11/23.
//

import ComposableArchitecture
import Foundation

struct CouponHistoryReducer: Reducer {
    struct State: Equatable {}
    
    enum Action: Equatable {
        case detailButtonTapped
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .detailButtonTapped:
                return .none
            }
        }
    }
}
