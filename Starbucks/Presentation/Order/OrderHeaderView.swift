//
//  OrderHeaderView.swift
//  Starbucks
//
//  Created by DEV IOS on 2023/11/16.
//

import SwiftUI

enum SelectOrderHeaderMenu {
    case all
    case myMenu
}

enum SelectOrderHeaderMenuDetail {
    case drink
    case food
    case merchandise
}

struct OrderHeaderView: View {
    @State var selectedMenu: SelectOrderHeaderMenu = .myMenu
    @State var selectedMenuDetail: SelectOrderHeaderMenuDetail = .drink
    
    var body: some View {
        VStack {
            ZStack(alignment: .leading) {
                HStack {
                    Button {
                        selectedMenu = .all
                    } label: {
                        Text("전체 메뉴")
                    }
                    .padding(.trailing, 20)
                    Button {
                        selectedMenu = .myMenu
                    } label: {
                        Text("나만의 메뉴")
                    }
                    Spacer()
                    Text("홀케이크 예약")
                }
                .padding([.leading, .trailing], 20)
                .foregroundColor(.black)
                Rectangle()
                    .frame(height: 1)
                    .offset(y: 16)
                    .foregroundColor(.gray.opacity(0.6))
                    .shadow(radius: 1, y: 2)
                
                Rectangle()
                    .foregroundColor(.green)
                    .frame(width: selectedMenu == .all ? 100 : 100, height: 3)
                    .offset(y: 15)
                    .offset(x: selectedMenu == .all ? 0 : 100)
                    .animation(.easeIn, value: selectedMenu)
            }
            HStack(spacing: 20) {
                Button {
                    selectedMenuDetail = .drink
                } label: {
                    Text("음료")
                        .foregroundColor(selectedMenuDetail == .drink ? .black : .gray)
                }
                
                Button {
                    selectedMenuDetail = .food
                } label: {
                    Text("푸드")
                        .foregroundColor(selectedMenuDetail == .food ? .black : .gray)
                }
                
                Button {
                    selectedMenuDetail = .merchandise
                } label: {
                    Text("상품")
                        .foregroundColor(selectedMenuDetail == .merchandise ? .black : .gray)
                }
                
                Spacer()
            }
            .padding(.top, 10)
            .padding([.leading, .trailing], 20)
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.gray.opacity(0.3))
        }
        .padding(.top, 10)
        .background(.white)
    }
}

struct OrderHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderHeaderView()
    }
}
