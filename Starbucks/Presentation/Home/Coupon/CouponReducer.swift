//
//  CouponReducer.swift
//  Starbucks
//
//  Created by DEV IOS on 2023/11/20.
//

import ComposableArchitecture
import Foundation

struct CouponReducer: Reducer {
    struct Destination: Reducer {
        enum State: Equatable {
            case addCoupon(AddCouponReducer.State = AddCouponReducer.State())
            case info(CouponInfoReducer.State = CouponInfoReducer.State())
        }
        
        enum Action: Equatable {
            case addCoupon(AddCouponReducer.Action)
            case info(CouponInfoReducer.Action)
        }
        
        var body: some ReducerOf<Self> {
            Scope(state: /State.addCoupon, action: /Action.addCoupon) {
                AddCouponReducer()
            }
            
            Scope(state: /State.info, action: /Action.info) {
                CouponInfoReducer()
            }
            
        }
    }
    
    struct State: Equatable {
        @PresentationState var destination: Destination.State?
        var couponCase: CouponCase = .usableCoupon
        var usableCoupon: UsableCouponReducer.State?
        var couponHistory: CouponHistoryReducer.State?
        
        init() {
            usableCoupon = UsableCouponReducer.State()
        }
    }
    
    enum Action: Equatable {
        case destination(PresentationAction<Destination.Action>)
        case usableCoupon(UsableCouponReducer.Action)
        case couponHistory(CouponHistoryReducer.Action)
        case menuButtonTapped(CouponCase)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .destination:
                return .none
            case .menuButtonTapped(let couponCase):
                state.couponCase = couponCase
                return .none
            }
        }
        .ifLet(\.$destination, action: /Action.destination) {
            Destination()
        }
        .ifLet(\.usableCoupon, action: /Action.usableCoupon) {
            UsableCouponReducer()
        }
        .ifLet(\.couponHistory, action: /Action.couponHistory) {
            CouponHistoryReducer()
        }
        .onChange(of: \.couponCase) { oldValue, newValue in
            Reduce { state, _ in
                switch newValue {
                case .couponHistory:
                    state.couponHistory = CouponHistoryReducer.State()
                    state.usableCoupon = nil
                    return .none
                case .usableCoupon:
                    state.usableCoupon = UsableCouponReducer.State()
                    state.couponHistory = nil
                    return .none
                }
            }
        }
    }
}
