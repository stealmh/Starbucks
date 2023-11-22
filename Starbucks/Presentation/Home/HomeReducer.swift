//
//  HomeReducer.swift
//  Starbucks
//
//  Created by mino on 2023/11/17.
//

import ComposableArchitecture
import Foundation

struct HomeReducer: Reducer {
    /// For Navigation
    struct Destination: Reducer {
        enum State: Equatable {
            case notice(NoticeReducer.State = NoticeReducer.State())
            case coupon(CouponReducer.State = CouponReducer.State())
            case whatsNew(WhatsNewReducer.State = WhatsNewReducer.State())
        }
        
        enum Action: Equatable {
            case notice(NoticeReducer.Action)
            case coupon(CouponReducer.Action)
            case whatsNew(WhatsNewReducer.Action)
        }
        
        var body: some ReducerOf<Self> {
            Scope(state: /State.notice, action: /Action.notice) {
                NoticeReducer()
            }
            Scope(state: /State.coupon, action: /Action.coupon) {
                CouponReducer()
            }
            Scope(state: /State.whatsNew, action: /Action.whatsNew) {
                WhatsNewReducer()
            }
        }
    }
    
    struct State: Equatable {
        @PresentationState var destination: Destination.State?
        var offset: CGFloat = 0
        var scrollUp: Bool = false
        var deleveryButtonSize: CGFloat = 210
        var progressbarPercent: Double = 0.0
        var recommendCoffee: IdentifiedArrayOf<RecommendCoffee> = RecommendCoffee.mock
        var noticeList: IdentifiedArrayOf<HomeNotice> = HomeNotice.mock
        var foodList: [String] = String.imageNameMock

    }
    
    enum Action: Equatable {
        case getOffset(CGFloat)
        case offsetDidChange(Bool)
        case onAppear
        case noticeButtonTapped
        case couponButtonTapped
        case whatsNewButtonTapped
        case destination(PresentationAction<Destination.Action>)
    }
    
    var body: some ReducerOf<Self> {
        Reduce(self.core)
        .ifLet(\.$destination, action: /Action.destination) {
            Destination()
        }
        .onChange(of: \.offset) { oldValue, newValue in
            let isScroll = oldValue - CGFloat(4000.0) < newValue - CGFloat(4000.0)
            Reduce { _, _ in
                    .run { send in await send(.offsetDidChange(isScroll)) }
            }
        }
    }
    
    private func core(state: inout State, action: Action) -> EffectOf<Self> {
        switch action {
        case .getOffset(let offset):
            state.offset = offset
            return .none
            
        case .offsetDidChange(let scrollUp):
            state.scrollUp = scrollUp
            state.deleveryButtonSize = scrollUp ? 70 : 210
            return .none
            
        case .onAppear:
            state.progressbarPercent = 70
            return .none
            
        case .destination:
            return .none
            
        case .noticeButtonTapped:
            state.destination = .notice()
            return .none
            
        case .couponButtonTapped:
            state.destination = .coupon()
            return .none
            
        case .whatsNewButtonTapped:
            state.destination = .whatsNew()
            return .none
        }
    }
}
