//
//  StartingPopupView.swift
//  Starbucks
//
//  Created by mino on 2023/11/15.
//

import SwiftUI

struct StartingPopupView: View {
    @Binding var popupToggle: Bool
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                Image("food")
                    .resizable()
            }
//            .frame(height: 200)
            
            Button {
                
            } label: {
                Text("자세히 보기")
                    .font(.body)
                    .bold()
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity, maxHeight: 50)
            .background(.green)
            .cornerRadius(40)
//            .padding([.leading, .trailing], 10)
            .padding(.horizontal, 10)
            .padding(.vertical, 10)
            HStack {
                
                Button {
                    //
                } label: {
                    Text("다시보지 않기")
                }
                
                Spacer()
                
                Button {
                    popupToggle = true
                } label: {
                    HStack {
                        Image(systemName: "multiply")
                        Text("닫기")
                    }
                    .fontWeight(.light)
                }
            }
            .foregroundColor(.black)
            .padding([.leading, .trailing], 50)
        }
    }
}

struct StartingPopupView_Previews: PreviewProvider {
    static var previews: some View {
        StartingPopupView(popupToggle: .constant(false))
    }
}

