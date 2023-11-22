//
//  PayView.swift
//  Starbucks
//
//  Created by DEV IOS on 2023/11/20.
//

import ComposableArchitecture
import SwiftUI

struct PayView: View {
    let store: StoreOf<PayReducer>
    @ObservedObject var viewStore: ViewStoreOf<PayReducer>
    
    init(store: StoreOf<PayReducer>) {
        self.store = store
        self.viewStore = ViewStore(self.store, observe: { $0 })
    }
}
//MARK: - View
extension PayView {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}
//MARK: - Preview
struct PayView_Previews: PreviewProvider {
    static var previews: some View {
        PayView(store: Store(initialState: .init(), reducer: { PayReducer() }))
    }
}
