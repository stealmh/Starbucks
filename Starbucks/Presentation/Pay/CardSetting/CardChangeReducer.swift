//
//  CardChangeReducer.swift
//  Starbucks
//
//  Created by mino on 2023/12/07.
//

import ComposableArchitecture
import Foundation

struct CardChangeReducer: Reducer {
    struct State: Equatable {
        var selectCard: Card
        var title: String
    }
    enum Action: Equatable {
        case popup
        case alert
        case cancelButtonTapped
        case okButtonTapped(Card)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .popup:
                return .none
            case .alert:
                return .none
            case .cancelButtonTapped:
                return .none
            case .okButtonTapped:
                return .none
            }
        }
    }
}
