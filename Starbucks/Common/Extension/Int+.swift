//
//  Int+.swift
//  Starbucks
//
//  Created by mino on 2023/12/05.
//

import Foundation

extension Int {
    /// 숫자를 시간형식으로 변환(mm:ss)
    var timerFormatter: String {
        return "\(self / 60):\(String(format: "%02d", self % 60))"
    }
    /// 금액을 원 단위로 `,`로 구분지어 String으로 변환
    var priceFormatter: String {
        let v = NumberFormatter()
        v.numberStyle = .decimal
        return v.string(from: NSNumber(value: self)) ?? ""
    }
}
