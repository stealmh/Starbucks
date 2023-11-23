//
//  CouponRegisterView.swift
//  Starbucks
//
//  Created by mino on 2023/10/25.
//

import ComposableArchitecture
import SwiftUI

struct AddCouponView: View {
    private let title = "쿠폰 등록"
    @FocusState private var focusField: AddCouponReducer.State.Field?
    @State var isPresented: Bool = false
    
    let store: StoreOf<AddCouponReducer>
    @ObservedObject var viewStore: ViewStoreOf<AddCouponReducer>
    init(store: StoreOf<AddCouponReducer>) {
        self.store = store
        self.viewStore = ViewStore(self.store, observe: { $0 })
    }

    var body: some View {
        VStack(alignment: .leading) {
            Divider()
            /// Top Line, Guide Label, Radio Button Header
            addCouponHeaderView
            /// Coupon Type
            switch viewStore.selectRadioButton {
            case .recipe:
                recipeCouponView
            case .mms:
                mmsCouponView
            case .star:
                starCouponView
            }
            Spacer()
            /// 등록하기
            registerButtonView
        }
//        .minimumScaleFactor(0.4)
        .navigationSetting(title)
    }
}
//MARK: - Preview
struct CouponRegisterView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AddCouponView(store: Store(initialState: .init(), reducer: { AddCouponReducer() }))
        }
    }
}
//MARK: -
extension AddCouponView {
    /// TextField Focusing을 위함 (AddCouponView.Field)
    enum Field: Hashable {
        case recipe1, recipe2, recipe3, recipe4
        case mms1, mms2, mms3
        case star1, star2, star3
    }
    /// Divide Line / Guide Label, Radio Button을 가진 View
    var addCouponHeaderView: some View {
        VStack(alignment: .leading, spacing: 0) {
            Rectangle()
                .frame(height: 0.2)
                .padding(.top, 5)
            Text("영수증 쿠폰, MMS 쿠폰 또는 Star 쿠폰 중 등록하고자 하시는 쿠폰을 선택하세요")
                .font(.subheadline)
                .padding([.top, .leading, .trailing], 10)
            /// Coupon Radio Button
            HStack {
                ForEach(RadioButtonType.allCases, id: \.self) { item in
                    radioButton(seleted: viewStore.selectRadioButton, item)
                        .onTapGesture { viewStore.send(.radioButtonTapped(item)) }
                }
            }
            .padding(10)
        }
    }
    /// 영수증 쿠폰
    var recipeCouponView: some View {
        VStack(alignment: .leading) {
            Text("영수증 쿠폰번호 17자리를 입력해주세요.")
                .font(.subheadline)
                .padding([.leading, .trailing], 10)
            HStack {
                textFieldChecker(text: viewStore.$recipeText1,
                                 nextText: viewStore.$recipeText2,
                                 focuseBinding: $focusField,
                                 field: .recipe1,
                                 nextField: .recipe2, limitCount: 4, nil)
                Text("-")
                textFieldChecker(text: viewStore.$recipeText2,
                                 nextText: viewStore.$recipeText3,
                                 focuseBinding: $focusField,
                                 field: .recipe2,
                                 nextField: .recipe3, limitCount: 5, nil)
                .frame(width: 100)
                Text("-")
                textFieldChecker(text: viewStore.$recipeText3,
                                 nextText: viewStore.$recipeText4,
                                 focuseBinding: $focusField,
                                 field: .recipe3,
                                 nextField: .recipe4, limitCount: 4, nil)
                Text("-")
                textFieldChecker(text: viewStore.$recipeText4,
                                 nextText: viewStore.$recipeText4,
                                 focuseBinding: $focusField,
                                 field: .recipe4,
                                 nextField: .recipe4, limitCount: 4, true)
            }
            .padding(10)
            /// 쿠폰 등록코드
            Text("쿠폰 등록코드 8자리를 입력해주세요")
                .padding([.leading, .trailing, .top], 10)
                .font(.subheadline)
            TextField(text: viewStore.$recipeCouponRegisterTextField) {
                
            }
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .keyboardType(.numberPad)
            .padding([.leading, .trailing], 10)
            
            Button {
                isPresented.toggle()
            } label: {
                ZStack {
                    Rectangle()
                        .fill(.brown.opacity(0.45))
                        .frame(height: 50)
                    Text("바코드 인식하기")
                        .foregroundColor(.brown)
                }
                .padding(10)
            }
            .navigationDestination(isPresented: $isPresented) {
                BarcodeScannerView(barcodeResult: viewStore.$recipeCouponRegisterTextField, isPresented: $isPresented)
            }
            
           VStack(alignment: .leading, spacing: 15) {
                Text("· 쿠폰으로 등록한 영수증 쿠폰은 등록해지가 불가능하며, 등록 이후 기존의 실물 쿠폰은 더 이상 사용하실 수 없습니다.")
                Text("· 등록된 쿠폰은 해당 계정에 등록된 스타벅스카드 또는 쿠폰의 QR코드를 제시하여 사용하실 수 있습니다.")
                Text("· 쿠폰 및 실물 쿠폰은 상업적으로 이용할 수 없으며, 스타벅스에서 제공하는 쿠폰 선물하기 기능 외 방법으로 전달된 쿠폰 사용으로 인해 발생된 문제에 대해서는 스타벅스가 책임지지 않습니다.")
                Text("· 쿠폰이 발행된 원 거래가 취소되는 경우, 등록된 쿠폰도 즉시 회수됩니다.")
            }
            .padding([.leading, .trailing], 10)
            .font(.caption2)
            .foregroundColor(.black.opacity(0.7))
        }
    }
    /// MMS 쿠폰
    var mmsCouponView: some View {
        VStack(alignment: .leading) {
            Text("MMS 쿠폰번호 13자리를 입력해주세요.")
                .font(.subheadline)
                .padding([.leading, .trailing], 10)
            HStack {
                textFieldChecker(text: viewStore.$mmsText1,
                                 nextText: viewStore.$mmsText2,
                                 focuseBinding: $focusField,
                                 field: .mms1,
                                 nextField: .mms2,
                                 limitCount: 4, nil)
                Text("-")
                textFieldChecker(text: viewStore.$mmsText2,
                                 nextText: viewStore.$mmsText3,
                                 focuseBinding: $focusField,
                                 field: .mms2,
                                 nextField: .mms3,
                                 limitCount: 5, nil)
                .frame(width: 100)
                Text("-")
                textFieldChecker(text: viewStore.$mmsText3,
                                 nextText: viewStore.$mmsText3,
                                 focuseBinding: $focusField,
                                 field: .mms3,
                                 nextField: .mms3,
                                 limitCount: 4, true)
            }
            .frame(width: 300)
            .padding(10)
            Text("수신자(선물 받은 사람)의 휴대폰 번호를 입력해주세요.")
                .padding(10)
                .font(.subheadline)
            TextField(text: viewStore.$mmsCouponPhoneNumberTextField) {
                
            }
            .keyboardType(.numberPad)
            .background(
                RoundedRectangle(cornerRadius: 0)
                    .strokeBorder(lineWidth: 1)
                    .opacity(0.4)
                    .frame(height: 40)
            )
            .padding(.top, 5)
            .padding([.leading, .trailing], 10)
            VStack(alignment: .leading, spacing: 15) {
                Text("· 쿠폰 등록 후에는 선물 받은 쿠폰의 문자 메세지가 삭제되었더라도 해당 계정에 등록된 스타벅스카드 또는 쿠폰QR코드를 제시하시면 사용하실 수 있습니다.")
                Text("· 쿠폰 및 실물 쿠폰은 상업적으로 이용할 수 없으며, 스타벅스에서 제공하는 쿠폰 선물하기가 기능 외 방법으로 전달된 쿠폰 사용으로 인해 발생된 문제에 대해서는 스타벅스가 책임지지 않습니다.")
            }
            .padding(.top, 25)
            .padding([.leading, .trailing], 10)
            .font(.caption2)
            .foregroundColor(.black.opacity(0.7))
        }
    }
    /// Star 쿠폰
    var starCouponView: some View {
        VStack(alignment: .leading) {
            Text("Star 쿠폰번호 13자리를 입력해주세요.")
                .font(.subheadline)
                .padding([.leading, .trailing], 10)
            HStack {
                textFieldChecker(text: viewStore.$starText1,
                                 nextText: viewStore.$starText2,
                                 focuseBinding: $focusField,
                                 field: .star1,
                                 nextField: .star2,
                                 limitCount: 4,
                                 nil)
                Text("-")
                textFieldChecker(text: viewStore.$starText2,
                                 nextText: viewStore.$starText3,
                                 focuseBinding: $focusField,
                                 field: .star2,
                                 nextField: .star3,
                                 limitCount: 5,
                                 nil)
                .frame(width: 100)
                Text("-")
                textFieldChecker(text: viewStore.$starText3,
                                 nextText: viewStore.$starText3,
                                 focuseBinding: $focusField,
                                 field: .star3,
                                 nextField: .star3,
                                 limitCount: 4,
                                 true)
            }
            .frame(width: 300)
            .padding(10)
        
        
        Text("PIN 번호를 8자리를 입력해주세요.")
            .padding(10)
            .font(.subheadline)
            TextField(text: viewStore.$starCouponPinNumberTextField) {
            
        }
        .keyboardType(.numberPad)
        .background(
            RoundedRectangle(cornerRadius: 0)
                .strokeBorder(lineWidth: 1)
                .opacity(0.4)
                .frame(height: 40)
        )
        .padding(.top, 5)
        .padding([.leading, .trailing], 10)
        VStack(alignment: .leading, spacing: 0) {
            ForEach(StarCouponGuide.mock, id: \.self) { text in
                Text(text.text)
                    .foregroundColor(text.id == "guide" ? .green : .black.opacity(0.7))
            }
            .padding([.leading, .trailing], 10)
            .font(.caption)
        }
        .padding(.top, 25)
        }
    }
    /// 등록하기 버튼
    var registerButtonView: some View {
        ZStack {
            Rectangle()
                .fill(.white)
                .frame(height: 75)
                .shadow(color: .gray.opacity(0.15), radius: 4)
            Rectangle()
                .fill(.green)
                .frame(height: 50)
                .padding(20)
            Text("등록하기")
                .foregroundColor(.white)
                .bold()
        }
    }
    /// 라디오 버튼 모양을 가진 쿠폰 버튼 View
    func radioButton(seleted: RadioButtonType,
                     _ type: RadioButtonType) -> some View {
        HStack {
            if seleted == type {
                Circle()
                    .stroke()
                    .background(Circle().frame(width: 10, height: 10))
                    .background(.clear)
                    .frame(width: 20, height: 20)
            } else {
                Circle()
                    .stroke()
                    .frame(width: 20, height: 20)
            }
            Text(type.title)
                .font(.callout)
                .padding(5)
        }
    }
    /// TextField끼리 연결해주는 함수입니다.
    /// - Parameter text: Binding시킬 String
    /// - Parameter nextText: 다음으로 넘어 갈 Text의 Binding String
    /// - Parameter focuseBinding: Focus State를 바인딩
    /// - Parameter field: 첫번째 TextField의 field 값
    /// - Parameter nextField: 다음으로 포커싱 되야 할 TextField의 field 값
    /// - Parameter limitCount: TextField를 몇 자리까지 인식할 것인지의 제한 범위
    /// - Returns: 그러한 조건을 만족하는 TextField를 반환합니다.
    func textFieldChecker(text: Binding<String>,
                          nextText: Binding<String>,
                          focuseBinding: FocusState<AddCouponReducer.State.Field?>.Binding,
                          field: AddCouponReducer.State.Field,
                          nextField: AddCouponReducer.State.Field,
                          limitCount: Int,
                          _ last: Bool?) -> some View {
        TextField(text: text, label: {
            
        })
        .focused(focuseBinding, equals: field)
        .background(
            RoundedRectangle(cornerRadius: 0)
                .strokeBorder(lineWidth: 1)
                .opacity(0.4)
                .frame(height: 40)
        )
        .multilineTextAlignment(.center)
        .keyboardType(.numberPad)
        .onChange(of: text.wrappedValue) { pinNumber in
            let pin = String(pinNumber.prefix(limitCount))
            text.wrappedValue = pin
            if pin.count >= limitCount {
                if let last { return }
                
                if nextText.wrappedValue.isEmpty {
                    focusField = nextField
                }
            }
        }
    }
}
//MARK: - Configure NavigationBar
fileprivate extension View {
    func navigationSetting(_ title: String) -> some View {
        self
            .navigationTitle(title)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: BackbuttonOnlyIcon())
            .toolbar {
                HStack {
                    NavigationLink {
                        
                    } label: {
                        Image(systemName: "info.circle")
                    }
                }
                .foregroundColor(.gray)
            }
    }
}
