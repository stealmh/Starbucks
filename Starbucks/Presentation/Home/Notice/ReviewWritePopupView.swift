//
//  ReviewWritePopupView.swift
//  Starbucks
//
//  Created by mino on 2023/10/25.
//

import SwiftUI

struct ReviewWritePopupView: View {
    @Binding var isPresented: Bool
    @Binding var style: PopupStyle
    @ObservedObject var viewModel: NoticeViewModel
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Rectangle()
                .cornerRadius(Constants.viewCornerRadius, corners: .allCorners)
                .foregroundColor(.white)
                .shadow(radius: 7)
            VStack(alignment: .leading) {
                Text(style.title)
                    .font(style == .review ? .title3 : .subheadline)
                    .fontWeight(style == .review ? .bold : .medium)
                    .padding(.leading, Constants.textLeading)
                    .padding(.top, Constants.textTop)
                HStack {
                    Text(style.content)
                        .fontWeight(.thin)
                        .lineSpacing(Constants.textSpacing)
                        .padding([.leading], Constants.textLeading)
                    Spacer()
                }
                Spacer()
                
                HStack(spacing: Constants.buttonSpacing) {
                    Spacer()
                    Button {
                        isPresented.toggle()
                    } label: {
                        Text(style.firstButtonTitle)
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
                        switch style {
                        case .deleteMessage:
                            viewModel.deleteMessage()
                        case .review:
                            viewModel.writeReview()
                        }
                    } label: {
                        Text(style.secondButtonTitle)
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
        .frame(height: style.viewHeight)
        .padding([.leading, .trailing], Constants.viewLeftRightPadding)
    }
}
//MARK: - Previews
struct ReviewWritePopupView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewWritePopupView(isPresented: .constant(false),
                             style: .constant(.review),
                             viewModel: NoticeViewModel())
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

