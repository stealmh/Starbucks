//
//  StarbucksApp.swift
//  Starbucks
//
//  Created by mino on 2023/10/18.
//

import ComposableArchitecture
import SwiftUI

@main
struct StickyHeaderApp: App {
    var body: some Scene {
        WindowGroup {
            TabBarView(store: StoreOf<RootReducer>(initialState: .init(), reducer: { RootReducer() }))
        }
    }
}
