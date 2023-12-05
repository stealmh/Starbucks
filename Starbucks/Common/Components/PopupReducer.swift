//
//  PopupReducer.swift
//  Starbucks
//
//  Created by DEV IOS on 2023/11/17.
//

import Foundation
import ComposableArchitecture

struct PopupReducer: Reducer {
    struct State: Equatable { }
    
    enum Action: Equatable {
        case dismissButtonTapped
        case neverShowButtonTapped
        case detailButtonTapped
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {

        switch action {
        case .detailButtonTapped:
            return .none
        case .neverShowButtonTapped:
            return .none
        case .dismissButtonTapped:
            return .none
        }
        
    }

}
