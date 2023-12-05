//
//  OrderReducer.swift
//  Starbucks
//
//  Created by DEV IOS on 2023/11/17.
//

import ComposableArchitecture
import Foundation

struct OrderReducer: Reducer {
    struct State: Equatable {}
    enum Action: Equatable {}
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
//            default: .none
            }
        }
    }
}
