//
//  CouponHistoryDetailReducer.swift
//  Starbucks
//
//  Created by DEV IOS on 2023/11/23.
//

import ComposableArchitecture
import Foundation

struct CouponHistoryDetailReducer: Reducer {
    struct State: Equatable {
        @BindingState var scrollDisable: Bool = false
        @BindingState var couponGuideCheck: Bool = true
    }
    
    enum Action: BindableAction, Equatable {
        case messageFoldButtonTapped
        case couponGuideButtonTapped
        case binding(BindingAction<State>)
    }
    
    var body: some ReducerOf<Self> {
        Reduce {state, action in
            switch action {
            case .messageFoldButtonTapped:
                state.scrollDisable.toggle()
                return .none
            case .couponGuideButtonTapped:
                state.couponGuideCheck.toggle()
                return .none
            case .binding:
                return .none
            }
        }
    }
}
