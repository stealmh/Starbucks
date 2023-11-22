//
//  CouponView.swift
//  Starbucks
//
//  Created by mino on 2023/10/25.
//

import ComposableArchitecture
import SwiftUI

struct CouponView: View {
    private let title = "쿠폰"
    @State private var selectedTabBar: CouponCase = .usableCoupon
    let store: StoreOf<CouponReducer>
    @ObservedObject var viewStore: ViewStoreOf<CouponReducer>
    var usableCouponList: [String] = []
    
    init(store: StoreOf<CouponReducer>) {
        self.store = store
        self.viewStore = ViewStore(self.store, observe: { $0 })
    }
}
//MARK: - View
extension CouponView {
    var body: some View {
        VStack {
            Rectangle()
                .frame(height: 0.2)
                .padding(.top, 5)
            
            GeometryReader { geometry in
                HStack(alignment: .center, spacing: 0) {
                    buttonUI(coupon: .usableCoupon, geo: geometry)
                    buttonUI(coupon: .couponHistory, geo: geometry)
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color.gray, lineWidth: 0.5)
                )
                .cornerRadius(6)
            }
            .padding(.top, 10)
            .padding([.leading, .trailing], 10)
            .frame(height: 60)
            
            switch selectedTabBar {
            case .usableCoupon:
                UsableCouponView()
            case .couponHistory:
                CouponHistoryView()
            }
        }
        .animation(.linear, value: selectedTabBar)
        .navigationSetting(title)
    }
}
//MARK: - Preview
struct CouponView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CouponView(store: Store(initialState: .init(), reducer: { CouponReducer() }))
        }
    }
}
//MARK: - Configure Layout
extension CouponView {
    func buttonUI(coupon: CouponCase, geo: GeometryProxy) -> some View {
        return HStack {
            Button {
                selectedTabBar = coupon
            } label: {
                Text(coupon.title)
                    .foregroundColor(selectedTabBar == coupon ? .white : .gray)
            }
            .frame(width: geo.size.width * 0.5, height: 45)
            .background(selectedTabBar == coupon ? .green : .white)
        }
    }
}
//MARK: - Configure NavigationBar
fileprivate extension View {
    func navigationSetting(_ title: String) -> some View {
        self
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(title)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: BackbuttonOnlyIcon())
            .toolbar(.hidden, for: .tabBar)
            .toolbar {
                HStack {
                    NavigationLink {
                        AddCouponView()
                    } label: {
                        Image(systemName: "plus")
                    }
                    
                    NavigationLink {
                        CouponInfoView()
                    } label: {
                        Image(systemName: "info.circle")
                    }
                    Spacer()
                }
                .foregroundColor(.gray)
            }
    }
}
