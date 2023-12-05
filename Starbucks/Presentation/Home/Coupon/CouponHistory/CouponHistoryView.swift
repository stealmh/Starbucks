//
//  CouponHistoryView.swift
//  Starbucks
//
//  Created by mino on 2023/11/22.
//

import ComposableArchitecture
import SwiftUI

enum CouponHistoryType {
    case expired
    case gift
    
    var title: String {
        switch self {
        case .expired: return "기간 만료"
        case .gift: return "쿠폰 선물"
        }
    }
    
    var imageName: String {
        switch self {
        case .expired: return "cup.and.saucer"
        case .gift: return "party.popper"
        }
    }
}

struct CouponHistoryView: View {
    let store: StoreOf<CouponHistoryReducer>
    @ObservedObject var viewStore: ViewStoreOf<CouponHistoryReducer>
    
    init(store: StoreOf<CouponHistoryReducer>) {
        self.store = store
        self.viewStore = ViewStore(self.store, observe: { $0 })
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                sampleCoupon(title: "오텀 사이즈 쿠폰 (~10/30)",
                             endDateString: "2023.10.23 부터 2023.10.30 까지",
                             historyType: .expired,
                             backgroundColor: .gray.opacity(0.2),
                             drilldown: false)
                sampleCoupon(title:"오텀 사이즈 쿠폰 (~10/30)",
                             endDateString: "2023.10.23 부터 2023.10.30 까지",
                             historyType: .expired,
                             backgroundColor: .white,
                             drilldown: false)
                sampleCoupon(title:"Birthday 쿠폰",
                             endDateString: "2023.10.23 부터 2023.10.30 까지 | 2023.09.20 선물",
                             historyType: .gift,
                             backgroundColor: .gray.opacity(0.2),
                             drilldown: true)
            }
        }
    }
}
// MARK: - Preview
struct CouponHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        CouponHistoryView(store: Store(initialState: .init(), reducer: { CouponHistoryReducer() }))
    }
}
// MARK: - Configure Layout
extension CouponHistoryView {
    private func sampleCoupon(title: String,
                              endDateString: String,
                              historyType: CouponHistoryType ,
                              backgroundColor color: Color,
                              drilldown: Bool) -> some View {
        HStack {
            VStack {
                Image(systemName: historyType.imageName)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .padding(.top, 15)
                Text(historyType.title)
                    .font(.caption)
            }
            .foregroundColor(.gray)
            .padding(10)
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.footnote)
                Text(endDateString)
                    .font(.caption)
            }
            .foregroundColor(.gray)
            Spacer()
            if drilldown {
                Button {
                    viewStore.send(.detailButtonTapped)
                } label: {
                    Image(systemName: "chevron.right")
                        .foregroundColor(.black)
                        .padding(10)
                }
                
            }
        }
        .background(color)
    }
    
}
