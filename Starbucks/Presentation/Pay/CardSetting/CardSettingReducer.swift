//
//  CardSettingReducer.swift
//  Starbucks
//
//  Created by DEV IOS on 2023/12/07.
//

import ComposableArchitecture
import Foundation

struct CardSettingReducer: Reducer {
    struct Destination: Reducer {
        enum State: Equatable {
            case alert(CardChangeReducer.State)
        }
        
        enum Action: Equatable {
            case alert(CardChangeReducer.Action)
        }
        var body: some ReducerOf<Destination> {
            Scope(state: /State.alert , action: /Action.alert) {
                CardChangeReducer()
            }
        }
    }
    
    struct State: Equatable {
        @PresentationState var destination: Destination.State?
    }
    
    enum Action: Equatable {
        case destination(PresentationAction<Destination.Action>)
        case popup
        case alert
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .popup:
                return .none
            case .alert:
                state.destination = .alert(CardChangeReducer.State())
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
