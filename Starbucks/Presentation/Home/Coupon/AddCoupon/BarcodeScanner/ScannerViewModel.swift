//
//  ScannerViewModel.swift
//  Starbucks
//
//  Created by mino on 2023/10/25.
//

import SwiftUI

final class BarcodeScannerViewModel: ObservableObject {
    @Published var scannedCode  = ""
    @Published var alertItem: AlertItem?
    
    var statusText: String {
        scannedCode.isEmpty ? "Barcode Not Scanned" : scannedCode
    }
    
    var statusColor: Color   {
        scannedCode.isEmpty ? .red : .green
    }
}
