//
//  PayView.swift
//  Starbucks
//
//  Created by mino on 2023/11/20.
//

import ComposableArchitecture
import SwiftUI

struct PayView: View {
    let store: StoreOf<PayReducer>
    @ObservedObject var viewStore: ViewStoreOf<PayReducer>
    @State var currentPage: InfoPaging = .person
    
    init(store: StoreOf<PayReducer>) {
        self.store = store
        self.viewStore = ViewStore(self.store, observe: { $0 })
    }
}
//MARK: - View
extension PayView {
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                let width = geo.size.width
                ScrollView {
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(alignment: .center, spacing: 0) {
                                ForEach(viewStore.cardList, id: \.id) { item in
                                    card(item)
                                        .frame(width: width * 0.95)
                                        .id(item)
                                }
                            }
                        }
                    HStack {
                        Spacer()
                        Text("Coupon")
                        Spacer()
                        Text("|")
                        Spacer()
                        Text("e-Gift Item")
                        Spacer()
                    }
                }
                .navigationTitle("Pay")
            }
            .toolbar {
                Button {
                    viewStore.send(.cardSettingToolbarTapped)
                } label: {
                    Image(systemName: "list.bullet")
                }
            }
            .navigationDestination(store: self.store.scope(state: \.$destination, action: { .destination($0) }), state: /PayReducer.Destination.State.popover, action: PayReducer.Destination.Action.popover) { store in
                CardSettingView(store: store)
            }
        }
        .onAppear {
            let bright = UIScreen.main.brightness
            viewStore.send(.onAppear(bright))
            UIScreen.main.brightness = 1.0
        }
        .onDisappear {
            UIScreen.main.brightness = viewStore.brightness ?? 0.5
        }
    }
}
//MARK: - Preview
struct PayView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PayView(store: Store(initialState: .init(), reducer: { PayReducer()._printChanges() }))
        }
    }
}
//MARK: - View
extension PayView {
    private func card(_ item: Card) -> some View {
        ZStack {
            Color.white
                .shadow(radius: 5, x: -3, y: 2)
            VStack {
                Image(item.cardImage)
                    .resizable()
                    .frame(height: 180)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(15)
                    .shadow(radius: 3, x: -8, y: 7)
                
                HStack {
                    Text(item.cardName)
                    Button {
                        //
                    } label: {
                        Circle()
                            .stroke(lineWidth: 0.5)
                            .frame(width: 20, height: 20)
                            .overlay {
                                Image(systemName: "star.fill")
                                    .resizable()
                                    .frame(width: 12, height: 12)
                                    .foregroundColor(item.isHighlight ?
                                        .yellow : .gray.opacity(0.5))
                            }
                            .foregroundColor(.gray.opacity(0.5))
                    }
                }
                Text("\(item.money.priceFormatter)원").bold()
                // 바코드
                Color.black
                    .frame(height: 65)
                // 핀번호
                Text(item.cardNumber.hideCardNumber)
                // 바코드 유효시간 타이머
                HStack {
                    Text("바코드 유효시간")
                    Text(viewStore.barcodeRemaining.timerFormatter)
                        .foregroundColor(Palette.stackBucksGreen)
                }
                .fontWeight(.light)
                .font(.callout)
                
                HStack(spacing: 50) {
                    Button {
                        //
                    } label: {
                        VStack {
                            Image(systemName: "dollarsign.arrow.circlepath")
                                .resizable()
                                .frame(width: 20, height: 20)
                            Text("자동 충전")
                        }
                    }
                    
                    Button {
                        //
                    } label: {
                        VStack {
                            Image(systemName: "dollarsign.circle")
                                .resizable()
                                .frame(width: 20, height: 20)
                            Text("일반 충전")
                        }
                    }

                }
                .foregroundColor(.black.opacity(0.7))
                .padding(.top, 10)
            }
            .padding(10)
        }
        .padding(10)
    }
}
