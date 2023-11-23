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
            
            IfLetStore(self.store.scope(state: \.usableCoupon, action: { .usableCoupon($0) })) { store in
                UsableCouponView(store: store)
            }
            
            IfLetStore(self.store.scope(state: \.couponHistory, action: { .couponHistory($0) })) { store in
                CouponHistoryView(store: store)
            }
            .navigationDestination(store: self.store.scope(state: \.$destination, action: {  .destination($0)}), state: /CouponReducer.Destination.State.couponHistoryDetail, action: CouponReducer.Destination.Action.couponHistoryDetail, destination: { store in
                CouponHistoryDetailView(store: store)
            })

        }
        .animation(.linear, value: viewStore.couponCase)
        .navigationSetting(title, viewStore: viewStore)
        .navigationDestination(store: self.store.scope(state: \.$destination, action: {  .destination($0)}), state: /CouponReducer.Destination.State.addCoupon, action: CouponReducer.Destination.Action.addCoupon, destination: { store in
            AddCouponView(store: store)
        })
        .navigationDestination(store: self.store.scope(state: \.$destination, action: {  .destination($0)}), state: /CouponReducer.Destination.State.info, action: CouponReducer.Destination.Action.info, destination: { store in
            CouponInfoView(store: store)
        })
    }
}
//MARK: - Preview
struct CouponView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CouponView(store: Store(initialState: .init(), reducer: { CouponReducer()._printChanges() }))
        }
    }
}
//MARK: - Configure Layout
extension CouponView {
    func buttonUI(coupon: CouponCase, geo: GeometryProxy) -> some View {
        return HStack {
            Button {
//                selectedTabBar = coupon
                viewStore.send(.menuButtonTapped(coupon))
            } label: {
                Text(coupon.title)
                    .foregroundColor(viewStore.couponCase == coupon ? .white : .gray)
            }
            .frame(width: geo.size.width * 0.5, height: 45)
            .background(viewStore.couponCase == coupon ? .green : .white)
        }
    }
}
//MARK: - Configure NavigationBar
fileprivate extension View {
    func navigationSetting(_ title: String, viewStore: ViewStoreOf<CouponReducer>) -> some View {
        self
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(title)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: BackbuttonOnlyIcon())
            .toolbar(.hidden, for: .tabBar)
            .toolbar {
                HStack {
                    Button {
                        viewStore.send(.addCouponToolbarTapped)
                    } label: {
                        Image(systemName: "plus")
                    }

                    Button {
                        viewStore.send(.infoToolbarTapped)
                    } label: {
                        Image(systemName: "info.circle")
                    }

                    Spacer()
                }
                .foregroundColor(.gray)
            }
    }
}
