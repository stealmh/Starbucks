//
//  String+.swift
//  Starbucks
//
//  Created by mino on 2023/11/20.
//

import Foundation

extension String {
    static let imageNameMock = ["choclate", "cookie", "food", "fries", "pizza", "sandwich"]
    /// 카드 비밀번호를 뒤 `6`자리를 제외하고 가립니다.
    var hideCardNumber: String {
        var result = ""
        let numericString = self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        for (idx, number) in numericString.enumerated() {
            if idx >= 10 {
                result += String(number)
            } else {
                result += "*"
            }
            if idx == 3 || idx == 7 || idx == 11 {
                result += "-"
            }
        }
        return result
    }
}
