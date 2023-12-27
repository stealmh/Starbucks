//
//  MyDTPassAlertView.swift
//  Starbucks
//
//  Created by mino on 2023/12/27.
//

import SwiftUI

struct MyDTPassAlertView: View {
    @Binding var isPresented: Bool
    @Binding var dtPassViewVisible: Bool
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(height: 170)
                .foregroundColor(.white)
                .shadow(radius: 3, x:1, y: -1)
//                .padding(20)
                .overlay {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("차량번호 등록을 원하시는 경우")
                            .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 0))
                            .fontWeight(.light)
                            .font(.callout)
                        Text("Other -> 계정정보 -> My DT Pass 메뉴에서 등록 가능합니다.")
                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                            .frame(height: 50)
                            .fontWeight(.light)
                            .font(.callout)
                        Spacer()
                        Divider()
                        HStack {
                            Button {
                                isPresented.toggle()
                                dtPassViewVisible.toggle()
                            } label: {
                                Spacer()
                                Text("확인")
                                    .padding(10)
                                    .foregroundColor(.green)
                                    .fontWeight(.light)
                                    .font(.callout)
                                Spacer()
                            }
                        }
                            
                    }
                }
                .padding(30)
        }
    }
}

struct MyDTPassAlertView_Previews: PreviewProvider {
    static var previews: some View {
        MyDTPassAlertView(isPresented: .constant(false), dtPassViewVisible: .constant(false))
    }
}
