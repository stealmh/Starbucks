//
//  CouponInfoReducer.swift
//  Starbucks
//
//  Created by DEV IOS on 2023/11/23.
//

import Combine
import ComposableArchitecture
import Foundation

struct CouponInfoReducer: Reducer {
    struct State: Equatable {
        @BindingState var currentPage: InfoPaging = .person
        var buttonHidden: Bool = false
        var isTimerRunning = true
    }
    
    enum Action: BindableAction, Equatable {
        case preNextButtonTapped(PreNextButtonType)
        case viewDidTapped
        case timerResult
        case onAppear
        case onDisappear
        case binding(BindingAction<State>)
    }
    
    @Dependency(\.continuousClock) var clock
    private enum CancelID { case timer }
    
    var body: some ReducerOf<Self> {
        Reduce {state, action in
            switch action {
            case .preNextButtonTapped(let type):
                switch (type, state.currentPage) {
                case (.previous, .person): return .none
                case (.next, .square): return .none
                case (.previous, .house):
                    state.currentPage = .person
                case (.previous, .circle):
                    state.currentPage = .house
                case (.previous, .square):
                    state.currentPage = .circle
                case (.next, .person):
                    state.currentPage = .house
                case (.next, .house):
                    state.currentPage = .circle
                case (.next, .circle):
                    state.currentPage = .square
                }
                return .none
            case .viewDidTapped:
                state.buttonHidden.toggle()
                return .none
            case .timerResult:
                state.buttonHidden = true
                return .none
            case .binding:
                return .none
            case .onAppear:
                return .run { send in
                    for await _ in self.clock.timer(interval: .seconds(3)) {
                        await send(.timerResult)
                    }
                }
                .cancellable(id: CancelID.timer, cancelInFlight: true)
            case .onDisappear:
                return .cancel(id: CancelID.timer)
            }
        }
    }
}
