//
//  ScannerView.swift
//  Starbucks
//
//  Created by mino on 2023/10/25.
//

import ComposableArchitecture
import SwiftUI

struct ScannerView: UIViewControllerRepresentable {
    
//    @Binding var scannedCode: String
//    @Binding var alertItem: AlertItem?
    @ObservedObject var viewStore: ViewStoreOf<ScannerReducer>
    
    init(viewStore: ViewStoreOf<ScannerReducer>) {
        self.viewStore = viewStore
    }
    
    func makeUIViewController(context: Context) -> ScannerVC {
        ScannerVC(scannerDelegate: context.coordinator)
    }
    
    func updateUIViewController(_ uiViewController: ScannerVC, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(scannerView: self)
    }
    
    final class Coordinator: NSObject, ScannerVCDelegate {
        
        private let scannerView: ScannerView
        
        init(scannerView: ScannerView) {
            self.scannerView = scannerView
        }
        
        func didFind(barcode: String) {
            print(#function)
            print("find barcode: \(barcode)")
//            scannerView.scannedCode = barcode
//            viewStore.send(.getBarcodeResult(barcode))
            scannerView.viewStore.send(.getBarcodeResult(barcode))
        }
        
        func didSurface(error: CameraError) {
            switch error {
            case .invalidDeviceInput:
                print("")
//                scannerView.alertItem = AlertContext.invalidDeviceInput
//                scannerView.alertItem = nil
            case .invalidScannedValue:
                print("")
//                scannerView.alertItem = AlertContext.invalidScannedType
//                scannerView.alertItem = nil
            }
        }
    }
}

