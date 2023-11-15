//
//  AddCouponModel.swift
//  Starbucks
//
//  Created by mino on 2023/10/25.
//

import Foundation

struct StarCouponGuide: Hashable {
    let id: String?
    let text: String
}

extension StarCouponGuide {
    static let mock: [StarCouponGuide] = [
        StarCouponGuide(id: "guide", text: "· Star 쿠폰은 스타벅스 리워드 회원에 한해서만 등록 및 사용이 가능한 쿠폰입니다."),
        StarCouponGuide(id: nil, text: "· 하나의 Star 쿠폰에는 여러 개의 별이 들어 있으며, Star 쿠폰을 My 쿠폰으로 등록하는 즉시 별로 전환됩니다. 전환된 별은 별 History에서 확인 가능합니다."),
        StarCouponGuide(id: nil, text: "· 전환된 별은 별 정책에 따라 승급/별 12개 쿠폰 발행에 사용됩니다."),
        StarCouponGuide(id: nil, text: "· Star 쿠폰은 쿠폰 그 자체로 사용할 수 없으며 My 쿠폰 등록을 통해 별로 전환하여 사용 가능합니다."),
        StarCouponGuide(id: nil, text: "· Star 쿠폰 유효기간 내에만 쿠폰 등록이 가능합니다."),
        StarCouponGuide(id: nil, text: "·Star 쿠폰으로 전환되는 별의 유효기간은 별 전환 시점으로부터 1년입니다."),
        StarCouponGuide(id: nil, text: "· 등록이 완료되어 별로 전환된 Star 쿠폰은 등록 취소 및 재사용 불가합니다."),
        StarCouponGuide(id: nil, text: "· Star 쿠폰은 상업적으로 이용할 수 없습니다.")]
}
