//
//  BarcodeScannerView.swift
//  Starbucks
//
//  Created by mino on 2023/10/25.
//

import SwiftUI

struct BarcodeScannerView: View {
    
    @StateObject var viewModel = BarcodeScannerViewModel()
    @Binding var barcodeResult: String
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationView {
            VStack  {
                ZStack(alignment: .center) {
                    Rectangle()
                        .fill(Color.black)
                        .frame(maxHeight: 500)
                    ScannerView(scannedCode: $barcodeResult,
                                alertItem: $viewModel.alertItem)
                    .frame(maxWidth: .infinity, maxHeight: 300)
                    Rectangle()
                        .fill(.red)
                        .frame(maxWidth: .infinity, maxHeight: 1)
                }
                
//                Spacer().frame(height: 60)
//
//                Label("Scanned Barcode:", systemImage: "barcode.viewfinder")
//                    .font(.title)
//
//                Text(viewModel.statusText)
//                    .bold()
//                    .font(.largeTitle)
//                    .foregroundColor(viewModel.statusColor)
//                    .padding()
                
            }
            .onChange(of: barcodeResult, perform: { newValue in
                print(newValue)
                barcodeResult = newValue
                isPresented.toggle()
            })
//            .navigationTitle("iOS Barcode Scanner")
//            .alert(item: $viewModel.alertItem) {alertItem in
//                Alert(title: Text(alertItem.title),
//                      message: Text(alertItem.message),
//                      dismissButton: alertItem.dismissButton)
//            }
        }
    }
}
