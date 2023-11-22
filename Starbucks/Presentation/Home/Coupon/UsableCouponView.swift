//
//  UsableCouponView.swift
//  Starbucks
//
//  Created by DEV IOS on 2023/11/22.
//

import SwiftUI

struct UsableCouponView: View {
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

struct UsableCouponView_Previews: PreviewProvider {
    static var previews: some View {
        UsableCouponView()
    }
}
