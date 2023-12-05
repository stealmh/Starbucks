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
}
