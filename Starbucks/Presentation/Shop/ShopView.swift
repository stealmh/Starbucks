//
//  ShopView.swift
//  Starbucks
//
//  Created by DEV IOS on 2023/11/16.
//

import ComposableArchitecture
import SwiftUI

struct ShopView: View {
    let store: StoreOf<ShopReducer>
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .navigationTitle("Starbucks Online Store")
        }
    }
}

struct ShopView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ShopView(store: Store(initialState: .init(), reducer: { ShopReducer() }))
        }
    }
}
