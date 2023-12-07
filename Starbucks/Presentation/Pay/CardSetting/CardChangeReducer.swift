//
//  CardChangeReducer.swift
//  Starbucks
//
//  Created by DEV IOS on 2023/12/07.
//

import ComposableArchitecture
import Foundation

struct CardChangeReducer: Reducer {
    struct State: Equatable {}
    enum Action: Equatable {
        case popup
        case alert
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .popup:
                return .none
            case .alert:
                return .none
            }
        }
    }
}
