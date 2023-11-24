//
//  ScannerReducer.swift
//  Starbucks
//
//  Created by DEV IOS on 2023/11/23.
//

import ComposableArchitecture
import Foundation

struct ScannerReducer: Reducer {
    struct State: Equatable {
        var barcodeResult: String = ""
    }
    
    enum Action: Equatable {
        case getBarcodeResult(String)
    }
    
    @Dependency (\.dismiss) var dismiss
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .getBarcodeResult:
                return .none
            }
        }
    }
}
