//
//  RootReducer.swift
//  Starbucks
//
//  Created by mhkim on 2023/11/17.
//

import Foundation
import ComposableArchitecture

struct RootReducer: Reducer {
    enum Tab { case home, pay, order, shop, other }
    
    struct State: Equatable {
        /// tab state
        var selectedTab: Tab = .home
        var home = HomeReducer.State()
        var pay = PayReducer.State()
        var order = OrderReducer.State()
        var shop = ShopReducer.State()
        var other = OtherReducer.State()
        
        var isLoading = true
        var welcom: PopupReducer.State?
        var isDeepLink: Bool = false
    }
    
    enum Action: Equatable {
        case home(HomeReducer.Action)
        case pay(PayReducer.Action)
        case order(OrderReducer.Action)
        case shop(ShopReducer.Action)
        case other(OtherReducer.Action)
        case welcome(PopupReducer.Action)
        case tabSelected(Tab)
        case onAppear
        case onAppearResponse(Bool)
        case deeplink(Tab)
        case deepLinkCheck(Bool)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .run { send in
                    try await Task.sleep(nanoseconds: 2 * 1_000_000_000)
                    await send(.onAppearResponse(false))
                }
            case let .onAppearResponse(complete):
                if !state.isDeepLink && state.isLoading == true {
                    state.welcom = PopupReducer.State()
                }
                state.isLoading = complete
                return .none
            /// PopupReducer Action
            case .welcome(.detailButtonTapped):
                return .none
            case .welcome(.neverShowButtonTapped):
                return .none
            case .welcome(.dismissButtonTapped):
                state.welcom = nil
                return .none
            case .tabSelected(let tab):
                state.selectedTab = tab
                return .none
            case .home:
                return .none
            case .pay:
                return .none
            case .deeplink(let tab):
                state.selectedTab = tab
                state.isDeepLink = true
                return .none
            case .deepLinkCheck(let isDeepLink):
                if isDeepLink {
                    state.isDeepLink = true
                } else {
                    state.isDeepLink = false
                }
                return .none
            }
        }
        .ifLet(\.welcom, action: /Action.welcome) {
            PopupReducer()
        }
        
        Scope(state: \.home, action: /RootReducer.Action.home) {
            HomeReducer()
        }
        
        Scope(state: \.pay, action: /RootReducer.Action.pay) {
            PayReducer()
        }
        
        Scope(state: \.order, action: /RootReducer.Action.order) {
            OrderReducer()
        }
        
        Scope(state: \.shop, action: /RootReducer.Action.shop) {
            ShopReducer()
        }
        
        Scope(state: \.other, action: /RootReducer.Action.other) {
            OtherReducer()
        }
        ._printChanges()
        
    }
}

