//
//  ReviewWritePopupView.swift
//  Starbucks
//
//  Created by mino on 2023/10/25.
//

import ComposableArchitecture
import SwiftUI

struct ReviewWritePopupView: View {
    let store: StoreOf<NoticePopupReducer>
    @ObservedObject var viewStore: ViewStoreOf<NoticePopupReducer>
    
    init(store: StoreOf<NoticePopupReducer>) {
        self.store = store
        self.viewStore = ViewStore(self.store, observe: { $0 })
    }
}
//MARK: - View
extension ReviewWritePopupView {
    var body: some View {
        ZStack(alignment: .topLeading) {
            Rectangle()
                .cornerRadius(Constants.viewCornerRadius, corners: .allCorners)
                .foregroundColor(.white)
                .shadow(radius: 7)
            VStack(alignment: .leading) {
                Text(viewStore.style.title)
                    .font(viewStore.style == .review ? .title3 : .subheadline)
                    .fontWeight(viewStore.style == .review ? .bold : .medium)
                    .padding(.leading, Constants.textLeading)
                    .padding(.top, Constants.textTop)
                HStack {
                    Text(viewStore.style.content)
                        .fontWeight(.thin)
                        .lineSpacing(Constants.textSpacing)
                        .padding([.leading], Constants.textLeading)
                    Spacer()
                }
                Spacer()
                
                HStack(spacing: Constants.buttonSpacing) {
                    Spacer()
                    Button {
                        viewStore.send(.dismiss)
                    } label: {
                        Text(viewStore.style.firstButtonTitle)
                            .padding([.leading, .trailing], 15)
                            .bold()
                            .foregroundColor(.green)
                            .background(
                                Capsule()
                                    .stroke()
                                    .fill(.green)
                                    .frame(height: Constants.buttonHeight))
                    }
                    Button {
                        switch viewStore.style {
                        case .deleteMessage:
                            viewStore.send(.deleteMessage)
                        case .review:
                            viewStore.send(.writeReview)
                        }
                    } label: {
                        Text(viewStore.style.secondButtonTitle)
                            .padding([.leading, .trailing], 15)
                            .bold()
                            .foregroundColor(.white)
                            .background(
                                Capsule()
                                    .fill(.green)
                                    .frame(height: Constants.buttonHeight))
                    }
                }
                .padding(.trailing, Constants.buttonTrailing)
                .padding(.bottom, Constants.buttonBottom)
            }

        }
        .frame(height: viewStore.style.viewHeight)
        .padding([.leading, .trailing], Constants.viewLeftRightPadding)
    }
}
//MARK: - Previews
struct ReviewWritePopupView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewWritePopupView(store: Store(initialState: .init(), reducer: { NoticePopupReducer()._printChanges() }))
    }
}
//MARK: - Constants
extension ReviewWritePopupView {
    private enum Constants {
        /// view
        static let viewLeftRightPadding: CGFloat = 25
        static let viewCornerRadius: CGFloat = 10
        /// text
        static let textLeading: CGFloat = 30
        static let textSpacing: CGFloat = 5
        static let textTop: CGFloat = 35
        /// button
        static let buttonSpacing: CGFloat = 15
        static let buttonBottom: CGFloat = 30
        static let buttonTrailing: CGFloat = 30
        static let buttonHeight: CGFloat = 35
    }
}

