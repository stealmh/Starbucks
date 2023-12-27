//
//  CardRegisterGuideView.swift
//  Starbucks
//
//  Created by mino on 2023/12/27.
//

import SwiftUI

struct CardRegisterGuideView: View {
    var body: some View {
        ZStack {
            VStack(spacing: 15) {
                Capsule()
                    .frame(width: 90, height: 5)
                    .foregroundColor(.black.opacity(0.65))
                Text("카드 등록 안내")
                    .font(.title2)
                HStack {
                    Text("Step.1")
                        .font(.body)
                        .bold()
                    Text("스타벅스 카드 뒷면의 16자리 일련번호를 입력해주세요.")
                        .font(.footnote)
                        .fontWeight(.light)
                    Spacer()
                }
                .padding([.leading], 10)
                RoundedRectangle(cornerRadius: 20)
                    .stroke(lineWidth: 0.2)
                    .frame(height: 150)
                    .padding([.leading, .trailing], 50)
                    .overlay {
                        ZStack {
                            Text("1234 5667 1234 1234")
                                .frame(width: 200, height: 40)
                            Capsule()
                                .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
                                .foregroundColor(.red)
                                .frame(width: 200, height: 40)
                        }
                    }
                HStack {
                    Text("Step.2")
                        .font(.body)
                        .bold()
                    Text("스크레치 제거 후 나타나는 Pin번호 8\n자리를 입력해주세요.")
                        .font(.footnote)
                        .fontWeight(.light)
                    Spacer()
                }
                .padding([.leading], 10)
                RoundedRectangle(cornerRadius: 20)
                    .stroke(lineWidth: 0.2)
                    .frame(height: 150)
                    .padding([.leading, .trailing], 50)
                    .overlay {
                        ZStack {
                            Text("1234 5667 1234 1234")
                                .frame(width: 200, height: 40)
                            Capsule()
                                .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
                                .foregroundColor(.red)
                                .frame(width: 200, height: 40)
                        }
                    }
                HStack {
                    Text("Step.3")
                        .font(.body)
                        .bold()
                    Text("모든 번호를 입력하셨다면 확인 버튼을 눌러주세요.")
                        .font(.footnote)
                        .fontWeight(.light)
                    Spacer()
                }
                .padding([.leading], 10)
                
                Capsule()
                    .foregroundColor(.green)
                    .frame(width: 200, height: 50)
                    .overlay {
                        ZStack {
                            Text("확인")
                                .foregroundColor(.white)
                                .bold()
                            Circle()
                                .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
                                .foregroundColor(.red)
                                .frame(width: 200, height: 70)
                        }
                    }
                Spacer()
            }
            .padding(.top, 7)
            Text("실제 앱에서는 사진으로 등록안내를 진행하고 있습니다")
                .rotationEffect(.degrees(35))
                .font(.largeTitle)
                .foregroundColor(.black.opacity(0.3))
        }
    }
}

struct CardRegisterGuideView_Previews: PreviewProvider {
    static var previews: some View {
        CardRegisterGuideView()
    }
}
