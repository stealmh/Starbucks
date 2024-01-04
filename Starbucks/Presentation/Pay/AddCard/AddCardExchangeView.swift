//
//  AddCardExchangeView.swift
//  Starbucks
//
//  Created by mino on 2023/12/08.
//

import SwiftUI

enum CardExchangeCase: CaseIterable {
    case getImage
    case barcode
    case exchangeNumber
    
    var icon: Image {
        switch self {
        case .getImage:
            return Image(systemName: "person")
        case .barcode:
            return Image(systemName: "person")
        case .exchangeNumber:
            return Image(systemName: "person")
        }
    }
    
    var title: String {
        switch self {
        case .getImage:
            return "교환권 이미지 불러오기"
        case .barcode:
            return "바코드 인식하기"
        case .exchangeNumber:
            return "교환권 번호 입력하기"
        }
    }
}

struct AddCardExchangeView: View {
}
//MARK: - Preview
struct AddCardExchangeView_Previews: PreviewProvider {
    static var previews: some View {
        AddCardExchangeView()
    }
}
//MARK: - Configure layout
extension AddCardExchangeView {
    var body: some View {
        VStack(spacing: 20) {
            Rectangle()
                .frame(height: 50)
                .foregroundColor(.gray.opacity(0.1))
                .overlay {
                    Text("모바일 카드 교환권을 등록하여 스타벅스 카드로 사용하세요.")
                        .font(.footnote)
                        .foregroundColor(.black.opacity(0.7))
                }
                .padding([.leading, .trailing], 20)
            
            ForEach(CardExchangeCase.allCases, id: \.self) { item in
                HStack {
                    item.icon
                        .resizable()
                        .padding(5)
                        .frame(width: 30, height: 30)
                    Text(item.title)
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                .padding([.leading, .trailing], 15)
                Divider()
                    .padding([.leading, .trailing], 15)
            }
            Rectangle().foregroundColor(.gray.opacity(0.1))
                .overlay {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("모바일 카드 교환권이란?")
                            .font(.title3)
                            .bold()
                        Text("카카오톡 선물하기 등 타사에서 발행하는 모바일 상품권으로, 스타벅스 카드로 교환하여 사용하실 수 있습니다.")
                            .font(.footnote)
                        Text("교환권을 등록하면 상품권에 표시된 금액이 충전된 스타벅스 카드가 신규 발급됩니다.")
                            .font(.footnote)
                        Text("카드 교환권 등록 취소는 카드 미사용 시에 한하여 7일 이내에 가능합니다.")
                            .font(.footnote)
                        Spacer()
                    }
                    .padding(EdgeInsets(top: 25,
                                        leading: 20,
                                        bottom: 10,
                                        trailing: 20))
                }
            
        }
    }
}
