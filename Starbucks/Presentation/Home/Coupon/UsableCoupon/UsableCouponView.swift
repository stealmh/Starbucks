//
//  UsableCouponView.swift
//  Starbucks
//
//  Created by DEV IOS on 2023/11/22.
//

import ComposableArchitecture
import SwiftUI

struct UsableCouponView: View {
    let store: StoreOf<UsableCouponReducer>
    @ObservedObject var viewStore: ViewStoreOf<UsableCouponReducer>
    
    init(store: StoreOf<UsableCouponReducer>){
        self.store = store
        self.viewStore = ViewStore(self.store, observe: { $0 })
    }
}
//MARK: - View
extension UsableCouponView {
    var body: some View {
        VStack {
            Spacer()
            Text("영수증 쿠폰, MMS 또는 Star 쿠폰을 \n우측 상단 + 버튼을 눌러 등록해 보세요.")
                .foregroundColor(.black.opacity(0.6))
                .font(.caption)
            Spacer()
        }
    }
}
//MARK: - Preview
struct UsableCouponView_Previews: PreviewProvider {
    static var previews: some View {
        UsableCouponView(store: Store(initialState: .init(), reducer: { UsableCouponReducer() }))
    }
}
