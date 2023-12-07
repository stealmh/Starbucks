//
//  CardSettingView.swift
//  Starbucks
//
//  Created by mino on 2023/12/07.
//

import ComposableArchitecture
import SwiftUI

struct Card: Hashable {
    let cardName: String
    let money: Int
    let cardImage: Color
    let isHighlight: Bool
}

struct CardSettingView: View {
    @State private var myCard: [Card] = [Card(cardName: "스타벅스 e카드(276347)",
                                              money: 300, cardImage: .orange, isHighlight: true),
                                         Card(cardName: "스타벅스 그린 워드마크 카드(041926)",
                                              money: 0, cardImage: .yellow, isHighlight: false)]
    let store: StoreOf<CardSettingReducer>
    @ObservedObject var viewStore: ViewStoreOf<CardSettingReducer>
    
    init(store: StoreOf<CardSettingReducer>) {
        self.store = store
        self.viewStore = ViewStore(self.store, observe: { $0 })
    }
}
//MARK: - View
extension CardSettingView {
    var body: some View {
        ScrollView {
            ForEach(myCard, id: \.self) { item in
                card(item)
            }
        }
        .navigationTitle("카드 (\(myCard.count))")
        .toolbar {
            Button {
                //
            } label: {
                Image(systemName: "plus.circle")
            }
            .foregroundColor(.black.opacity(0.7))
        }
        .fullScreenCover(store: self.store.scope(state: \.$destination, action: { .destination($0) }), state: /CardSettingReducer.Destination.State.alert, action: CardSettingReducer.Destination.Action.alert) { store in
            CardChangePopUpView(store: store)
                .presentationBackground(.gray.opacity(0.6))
        }
        .transaction { transaction in
            transaction.disablesAnimations = true
        }
    }
}
//MARK: - Preview
struct CardSettingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CardSettingView(store: Store(initialState: .init(), reducer: { CardSettingReducer() }))
        }
    }
}
//MARK: - Configure Layout
extension CardSettingView {
    private func card(_ item: Card) -> some View {
        HStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: item.isHighlight ? 140 : 90,
                       height: item .isHighlight ? 100 : 70)
            VStack(alignment: .leading) {
                Text(item.cardName)
                    .font(item.isHighlight ? .title3 : .system(.callout))
                    .foregroundColor(item.isHighlight ? .black : .gray)
                Text("\(item.money)원")
                    .font(item.isHighlight ? .title : .title2)
                    .bold()
            }
            .padding(.leading, 10)
            Spacer()
            Button {
                
                viewStore.send(.alert)
                
            } label: {
                Circle()
                    .stroke(lineWidth: 0.5)
                    .frame(width: 35, height: 35)
                    .overlay {
                        Image(systemName: "star.fill")
                            .resizable()
                            .frame(width: 15, height: 15)
                            .foregroundColor(item.isHighlight ? .yellow : .gray.opacity(0.5))
                    }
                    .foregroundColor(.gray)
            }
        }
        .padding(20)
    }
}
