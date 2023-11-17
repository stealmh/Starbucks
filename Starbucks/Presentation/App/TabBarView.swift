//
//  TabBarView.swift
//  Starbucks
//
//  Created by mino on 2023/10/18.
//

import SwiftUI

struct TabBarView: View {
    @State private var tabNumber = 0
    @State private var popupViewToggle = false
    @State private var isLoading = true

    var body: some View {
        if popupViewToggle { tabbarView }
        else { StartingPopupView(popupToggle: $popupViewToggle) }
    }
}
//MARK: - Preview
struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
//MARK: - Configure Layout
extension TabBarView {
    
    var tabbarView: some View {
        ZStack {
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .frame(width: 50, height: 50)
            } else {
                TabView(selection: $tabNumber) {
                    Home()
                        .tabItem {
                                Image(systemName: "house.fill")
                                Text("홈")
                        }
                        .tag(0)
                    
                    Text("hello")
                        .tabItem {
                            Image(systemName: "creditcard.fill")
                            Text("Pay")
                        }
                        .tag(1)
                    
                    OrderView()
                        .tabItem {
                            Image(systemName: "cup.and.saucer")
                            Text("Order")
                        }
                        .tag(2)
                    
                    Text("hello")
                        .tabItem {
                            Image(systemName: "cart")
                            Text("Shop")
                        }
                        .tag(3)
                    
                    OtherView()
                        .tabItem {
                            Image(systemName: "ellipsis")
                            Text("Other")
                        }
                        .tag(4)
                }
                .accentColor(.green)
            }
        }
        .onAppear {
            Task {
                try await Task.sleep(nanoseconds: 2 * 1_000_000_000)
                isLoading.toggle()
            }
        }
    }
}
