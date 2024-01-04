//
//  AddCardView.swift
//  Starbucks
//
//  Created by mino on 2023/12/08.
//

import ComposableArchitecture
import SwiftUI

struct AddCardView: View {
    let store: StoreOf<AddCardReducer>
    @ObservedObject var viewStore: ViewStoreOf<AddCardReducer>
    @State private var selectedTab = 0
    
    init(store: StoreOf<AddCardReducer>) {
        self.store = store
        self.viewStore = ViewStore(self.store, observe: { $0 })
    }
    
}
//MARK: - View
///Todo: 슬라이드에 따라 실시간으로 하단 초록바가 이동하게 수정하기
extension AddCardView {
    var body: some View {
        VStack(spacing: 5) {
            HStack(spacing: 40) {
                Button {
                    selectedTab = 0
                } label: {
                    Text("스타벅스 카드")
                        .frame(width: 100)
                        .font(selectedTab == 0 ? .headline : .body)
                        .foregroundColor(selectedTab == 0 ? .black : .gray)
                }
                Button {
                    selectedTab = 1
                } label: {
                    Text("카드교환권")
                        .frame(width: 80)
                        .font(selectedTab == 1 ? .headline : .body)
                        .foregroundColor(selectedTab == 1 ? .black : .gray)
                }
                Spacer()
            }
            .padding(.leading, 10)
            HStack {
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(height: 3)
                        .foregroundColor(.black.opacity(0.2))
                        .shadow(radius: 1, y: 2)
                        .offset(y: 2)
                    Rectangle()
                        .frame(width:120, height: 5)
                        .foregroundColor(.green.opacity(0.7))
                        .offset(x: selectedTab == 1 ? 130 : 0)
                        .animation(.easeOut(duration: 0.2), value: selectedTab)
                }
                Spacer()
            }
            TabView(selection: $selectedTab) {
                AddStarbucksCardView()
                    .tag(0)
                AddCardExchangeView()
                    .tag(1)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
//            .gesture(
//                DragGesture()
//                    .onEnded({ value in
//                        if value.translation.width < 0 {
//                            self.selectedTab = 1
//                        } else if value.translation.width > 0 {
//                            self.selectedTab = 0
//                        }
//                    })
//            )
            .navigationTitle("카드 등록")
        }
    }
}
//MARK: - Preview
struct AddCardView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AddCardView(store: Store(initialState: .init(), reducer: { AddCardReducer() }))
        }
    }
}
