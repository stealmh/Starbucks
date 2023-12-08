//
//  PayReducer.swift
//  Starbucks
//
//  Created by mino on 2023/11/17.
//

import ComposableArchitecture
import Foundation

struct PayReducer: Reducer {
    struct State: Equatable {
        @PresentationState var destination: Destination.State?
        /// 유저의 화면밝기
        var cardList: IdentifiedArrayOf<Card> = []
        var brightness: CGFloat?
        var barcodeRemaining = 120
        var viewStart: Bool = false
    }
    enum Action: Equatable {
        case destination(PresentationAction<Destination.Action>)
        case cardSettingToolbarTapped
        case onAppear(CGFloat)
        case onDisappear
        case timerTicks
    }
    
    @Dependency(\.continuousClock) var clock
    private enum CancelID { case timer }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear(let brightValue):
                if !state.viewStart {
                    state.cardList = Card.mock
                    state.viewStart = true
                }
                state.brightness = brightValue
                return .run { send in
                    for await _ in self.clock.timer(interval: .seconds(1)) {
                        await send(.timerTicks)
                    }
                }
                .cancellable(id: CancelID.timer, cancelInFlight: true)
                
            case .onDisappear:
                return .cancel(id: CancelID.timer)
            case .timerTicks:
                if state.barcodeRemaining > 0 {
                    state.barcodeRemaining -= 1
                } else {
                    state.barcodeRemaining = 119
                }
                return .none
            case .cardSettingToolbarTapped:
                state.destination = .popover(CardSettingReducer.State(cardList: state.cardList))
                return .none
            case .destination(.presented(.popover(.cardSortComplted(let cardList)))):
                state.cardList = cardList
                return .none
            case .destination:
                return .none
            }
        }
        .ifLet(\.$destination, action: /Action.destination) {
            Destination()
        }
    }
}
//MARK: - Navigation
extension PayReducer {
    struct Destination: Reducer {
        enum State: Equatable {
            case popover(CardSettingReducer.State)
        }
        
        enum Action: Equatable {
            case popover(CardSettingReducer.Action)
        }
        
        var body: some ReducerOf<Destination> {
            Scope(state: /State.popover, action: /Action.popover) {
                CardSettingReducer()
            }
        }
    }
}

