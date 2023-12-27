//
//  CardChangePopUpView.swift
//  Starbucks
//
//  Created by mino on 2023/12/07.
//

import ComposableArchitecture
import SwiftUI

struct CardChangePopUpView: View {
    /// Properties
    let store: StoreOf<CardChangeReducer>
    @ObservedObject var viewStore: ViewStoreOf<CardChangeReducer>
    /// Initializer
    init(store: StoreOf<CardChangeReducer>) {
        self.store = store
        self.viewStore = ViewStore(self.store, observe: { $0 })
    }
    
}
//MARK: - View
extension CardChangePopUpView {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .foregroundColor(.white)
                .shadow(radius: 4, x: 1, y: -2)
            VStack(spacing: 0) {
                Spacer()
                VStack(alignment: .center, spacing: Constants.titleContentsSpacing) {
                    Text("[\(viewStore.title)] 카드를 대표카드로 변경할까요?")
                        .lineLimit(3)
                        .font(.headline).bold()
                    Text("대표카드로 설정할 경우, 리스트 최상단에 고정됩니다.")
                        .font(.caption)
                }
                .padding(Constants.titleContentsPadding)
                Spacer()
                Rectangle().frame(height: 1)
                    .foregroundColor(.gray.opacity(0.2))
                HStack(alignment: .center, spacing: 0) {
                    Button(action: { viewStore.send(.cancelButtonTapped) }) {
                        Text("아니오")
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.gray)
                    }
                    Rectangle().frame(width: 1, height: Constants.buttonHeight)
                        .foregroundColor(.gray.opacity(0.2))
                    Button(action: { viewStore.send(.okButtonTapped(viewStore.selectCard)) }) {
                        Text("예")
                            .frame(maxWidth: .infinity)
                            .foregroundColor(Palette.stackBucksGreen)
                    }

                }
                .fixedSize(horizontal: false, vertical: true)
                .font(.callout)
            }
        }
        .frame(height: Constants.popupHeight)
        .padding([.leading, .trailing], Constants.leadingTrailingPadding)
    }
}
//MARK: - Preview
struct CardChangePopUpView_Previews: PreviewProvider {
    static var previews: some View {
        CardChangePopUpView(store: Store(initialState: .init(selectCard: Card(cardName: "cardName", cardNumber: "2312-5521-3364-3216",cardImage: "cookie" ,money: 3, isHighlight: true), title: "card"),
                                         reducer: { CardChangeReducer() }))
    }
}
//MARK: - Constants
extension  CardChangePopUpView {
    private enum Constants {
        /// 팝업뷰의 높이
        static let popupHeight: CGFloat = 200
        /// 팝업뷰의 좌우 padding (width 대체)
        static let leadingTrailingPadding: CGFloat = 30
        /// 팝업뷰 cornerRadius
        static let cornerRadius: CGFloat = 10
        /// 버튼의 높이
        static let buttonHeight: CGFloat = 50
        /// 팝업뷰 내부의 `제목` 과  `내용` 사이의 간격
        static let titleContentsSpacing: CGFloat = 20
        /// 팝업뷰 내부의 패딩값
        static let titleContentsPadding: EdgeInsets = EdgeInsets(top: 10,
                                                                 leading: 10,
                                                                 bottom: 0,
                                                                 trailing: 10)
    }
}
