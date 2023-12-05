//
//  CouponHistoryDetailView.swift
//  Starbucks
//
//  Created by mino on 2023/11/22.
//

import ComposableArchitecture
import SwiftUI

struct CouponHistoryDetailView: View {
    private let title: String = "선물내역"
//    @State var scrollDisable: Bool = false
//    @State var couponGuideCheck: Bool = true
    let store: StoreOf<CouponHistoryDetailReducer>
    @ObservedObject var viewStore: ViewStoreOf<CouponHistoryDetailReducer>
    
    init(store: StoreOf<CouponHistoryDetailReducer>) {
        self.store = store
        self.viewStore = ViewStore(self.store, observe: { $0 })
    }
    
    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            let height = geo.size.height
            ScrollView {
                VStack(spacing: 0) {
                    Rectangle()
                        .frame(height: width * 0.40)
                        .cornerRadius(40, corners: [.bottomLeft, .bottomRight])
                        .foregroundColor(Palette.stackBucksGreen)
                        .overlay {
                            VStack(spacing: 5) {
                                Text("🥳")
                                    .padding(.top, 20)
                                Text("선물 전송이 완료되었습니다!")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                Spacer()
                                Capsule()
                                    .foregroundColor(.white)
                                    .frame(height: width * 0.1)
                                    .overlay {
                                        HStack {
                                            Image(systemName: "gift.fill")
                                                .resizable()
                                                .frame(width: 25, height: 25)
                                                .foregroundColor(.green)
                                            Text("Birthday 쿠폰")
                                            Spacer()
                                        }
                                        .padding(.leading, 20)
                                    }
                                    .padding([.leading, .trailing], 30)
                                
                                Button {
                                    viewStore.send(.messageFoldButtonTapped)
                                } label: {
                                    let openText = "메세지 내용 열기"
                                    let closeText = "메세지 내용 닫기"
                                    Text(viewStore.scrollDisable ? closeText : openText)
                                        .foregroundColor(.gray)
                                        .font(.callout)
                                        .animation(.easeIn, value: viewStore.scrollDisable)
                                }
                                .padding(EdgeInsets(top: 10, leading: 0, bottom: 20, trailing: 0))
                                
                            }
                        }
                    DisclosureGroup(isExpanded: viewStore.$scrollDisable) {
                        ZStack {
                            VStack {
                                Image("pizza")
                                    .resizable()
                                    .foregroundColor(.white)
                                    .padding(EdgeInsets(top: 30, leading: 30, bottom: 10, trailing: 30))
                                    .frame(height: 240)
                                    .overlay {
                                        VStack {
                                            Spacer()
                                            HStack {
                                                Spacer()
                                                Circle()
                                                    .frame(width: 15, height: 15)
                                                    .padding(EdgeInsets(top: 20, leading: 0, bottom: 10, trailing: 0))
                                                Spacer()
                                                Circle()
                                                    .frame(width: 15, height: 15)
                                                    .padding(EdgeInsets(top: 20, leading: 0, bottom: 10, trailing: 0))
                                                Spacer()
                                            }
                                            .foregroundColor(.green.opacity(0.4))
                                        }
                                    }
                                Rectangle()
                                    .foregroundColor(.white)
                                    .frame(height: 150)
                                    .padding(EdgeInsets(top: 00, leading: 30, bottom: 30, trailing: 30))
                                    .overlay {
                                        VStack {
                                            HStack {
                                                Spacer()
                                                Circle()
                                                    .frame(width: 15, height: 15)
                                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                                                Spacer()
                                                Circle()
                                                    .frame(width: 15, height: 15)
                                                    .padding(EdgeInsets(top: 00, leading: 0, bottom: 10, trailing: 0))
                                                Spacer()
                                            }
                                            .foregroundColor(.green.opacity(0.4))
                                            Spacer()
                                        }
                                    }
                            }
                            .background(.green.opacity(0.4))
                            HStack {
                                Rectangle()
                                    .frame(width: 7, height: 40)
                                    .cornerRadius(10, corners: .allCorners)
                                    .padding(.top, 50)
                                
                                Rectangle()
                                    .frame(width: 7, height: 40)
                                    .cornerRadius(10, corners: .allCorners)
                                    .padding(.top, 50)
                                    .padding(.leading, 134)
                            }
                        }
                        .opacity(viewStore.scrollDisable ? 1 : 0)
                    } label: {
                        Text("")
                    }
                    .buttonStyle(PlainButtonStyle()).accentColor(.clear).disabled(true)
//                    .animation(.easeInOut, value: viewStore.scrollDisable)
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("받는 사람")
                            Text("보낸일시")
                            Text("사용 유효기간")
                        }
                        .frame(width: width * 0.3)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("김민호 | 010-****-0000")
                            Text("2023.09.20 오전 10:37")
                            Text("2023.09.08 부터 2023.10.06 까지")
                        }
                        Spacer()
                        
                    }
                    .font(.callout)
                    .foregroundColor(.black.opacity(0.6))
                    .padding([.leading], 10)
                    HStack {
                        /// Todo: 쿠폰을 사용했을 때만 보여주게 Bool 변수 추가
                        Text("받는 분이 e-Coupon을 등록 하였습니다.")
                            .font(.callout)
                            .foregroundColor(.red)
                        Spacer()
                    }
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 0))
                    //            .padding([.leading, .top], 10)
                    Divider()
                    VStack(spacing: 10) {
                        HStack {
                            VStack(alignment: .leading, spacing: 0) {
                                Text("받는 사람")
//                                    .frame(width: width * 0.3)
                                    .padding(.trailing, 10)
                            }
                            .frame(width: width * 0.3)
                            
                            VStack(alignment: .leading) {
                                Text("2023.09.20 선물")
                            }
                            Spacer()
                        }
                        .font(.callout)
                        .foregroundColor(.black.opacity(0.6))
                        
                        DisclosureGroup(isExpanded: viewStore.$couponGuideCheck) {
                            Rectangle()
                                .stroke(style: .init(lineWidth: 0.5))
//                                .frame(height: couponGuideCheck ? height * 0.4 : 0)
                                .frame(minHeight: viewStore.couponGuideCheck ? height * 0.35 : 0)
                                .padding(.trailing, 18)
                                .overlay {
                                    VStack(alignment: .leading, spacing: 0) {
                                        Text("- 스타벅스 매장에서 파트너가 제조한 음료 1잔(Tall) 무료 제공")
                                        Text("- Free Extra 1개 제공")
                                        Text("- 병음료, 생수, 요거트, 바나나 음료, 리저브/티바나 특화 음료, 특정 지역/매장\n특화 음료, 단일 사이즈 음료, 일부 프로모션 음료, 트렌타 사이즈 음료 등 일부 음료 제외")
                                        Text("- 스타벅스 전 매장에서 이용 가능하며, 유효기간이 지나면 사용 여부와\n관계없이 소멸\n(미군부대, 공항 및 일부 입점 매장 쿠폰 사용 불가)")
                                        Text("- 임직원 할인 및 중복할인 불가")
                                        Text("- 타 쿠폰 및 세트메뉴와 중복 사용 불가")
                                        Text("- 현금 및 다른 상품으로 대체 수령 불가")
                                        Text("*e-쿠폰은 상업적으로 이용할 수 없으며, 스타벅스에서 제공된 e-쿠폰 선물하기\n 기능이 아닌 모바일 MMS로 전달된 쿠폰 사용으로 인해 발생된 문제에 대해서는 스타벅스가 책임을 지지 않습니다.")
                                    }
                                    .minimumScaleFactor(0.7)
//                                    .background(.red)
                                    .padding(.trailing, 18)
                                    .padding(10)
                                    .foregroundColor(.black.opacity(0.6))
                                    .font(.caption)
                                    .opacity(viewStore.couponGuideCheck ? 1 : 0)
                                }
                        } label: {
                            Rectangle()
                                .stroke(style: .init(lineWidth: 0.5))
                                .frame(height: height * 0.06)
                                .overlay {
                                    VStack {
                                        HStack {
                                            Text("쿠폰 유의사항")
                                                .font(.callout)
                                                .bold()
                                            Spacer()
                                            Circle()
                                                .stroke(style: .init(lineWidth: 0.1))
                                                .overlay {
                                                    Image(systemName: "chevron.down")
                                                }
                                                .frame(width: 30, height: 30)
                                        }
                                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                                    }
                                    Spacer()
                                }
                        }
                        //                .padding(.top, 10)
                        .padding(.leading, 20)
                        .buttonStyle(PlainButtonStyle()).accentColor(.clear).disabled(true)
                        .animation(.easeInOut, value: viewStore.couponGuideCheck)
                        .onTapGesture {
                            viewStore.send(.couponGuideButtonTapped)
                        }
                    }
                    //            .animation(.easeInOut, value: !couponGuideCheck)
                    .padding(EdgeInsets(top: 10, leading: 00, bottom: 0, trailing: 0))
                }
            }
            .scrollDisabled(!viewStore.scrollDisable)
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: BackbuttonOnlyIcon())
        }
        
    }
}

struct CouponHistoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CouponHistoryDetailView(store: Store(initialState: .init(), reducer: { CouponHistoryDetailReducer() }))
        }
    }
}
