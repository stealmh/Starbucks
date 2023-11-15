//
//  Alert.swift
//  Starbucks
//
//  Created by mino on 2023/10/25.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: String
    let message: String
    let dismissButton: Alert.Button
}

struct AlertContext {
    static let invalidDeviceInput = AlertItem(title: "카메라 오류",
                                              message: "카메라에 문제가 생겨 바코드를 인식할 수 없습니다.",
                                              dismissButton: .default(Text("확인")))
    
    static let invalidScannedType = AlertItem(title: "잘못된 바코드 종류입니다",
                                              message: "8자리의 바코드, 13자리의 바코드만 인식할 수 있습니다.",
                                              dismissButton: .default(Text("확인")))
}
