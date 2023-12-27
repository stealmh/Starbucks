//
//  AddCardReducer.swift
//  Starbucks
//
//  Created by mino on 2023/12/08.
//

import ComposableArchitecture
import Foundation

struct AddCardReducer: Reducer {
    struct State: Equatable {}
    enum Action: Equatable {}
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {}
        }
    }
}
