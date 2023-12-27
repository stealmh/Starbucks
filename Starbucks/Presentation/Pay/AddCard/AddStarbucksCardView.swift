//
//  AddStarbucksCardView.swift
//  Starbucks
//
//  Created by mino on 2023/12/08.
//

import ComposableArchitecture
import Combine
import SwiftUI

struct AddStarbucksCardView: View {
    enum Field {
        case cardName
        case cardNumber
        case pinNumber
        case car
    }
    
    /// card Name
    @State private var cardNameText: String = ""
    @State private var cardNamePlaceHolderText = "카드명 최대 20자 (선택)"
    @State private var didTappedCardNameTextField: Bool = false
    @State private var cardNameTitleVisible = false
    /// card Number
    @State private var cardNumberText: String = ""
    @State private var cardNumberPlaceHolderText = "스타벅스 카드번호 16자리 (필수)"
    @State private var cardNumberUnderlineColor: Color = .gray
    @State private var cardNumberTitleVisible = false
    @State private var cardNumberGuideText = ""
    /// pin Number
    @State private var pinNumberText: String = ""
    @State private var pinNumberPlaceHolderText = "Pin번호 8자리 (필수)"
    @State private var pinNumberUnderlineColor: Color = .gray
    @State private var pinNumberTitleVisible = false
    @State private var pinNumberGuideText = ""
    /// Car
    @State private var carNumberText: String = ""
    @State private var carNumberPlaceHolderText = "약관에 동의해주세요"
    @State private var carNumberUnderlineColor: Color = .gray
    @State private var carNumberTitleVisible = false
    @State private var carNumberGuideText = ""
    
    @State private var didTappedFirstDTPassButton: Bool = false
    @State private var didTappedSecondDTPassButton: Bool = false
    
    private var firstResponseSubject = PassthroughSubject<Bool, Never>()
    private var secondResponseSubject = PassthroughSubject<Bool, Never>()
    
    @State private var selectedCarColor: String = "선택 안함"
    private let carColor: [String] = ["선택 안 함", "화이트", "블랙", "그레이", "실버", "블루&네이비", "레드", "그린", "브라운&베이지", "옐로우&오렌지", "기타"]
    @State private var pickerVisible: Bool = false
    @State private var didTappedPinNumberGuideButton: Bool = false
    @State private var dtPassAlertVisible = false
    @State private var dtPassViewVisible = true
    @State private var termButtonChecked = false
    @FocusState private var focusField: Field?
}
//MARK: - View
extension AddStarbucksCardView {
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    cardNameView
                    cardNumberView
                    pinNumberView
                    cardRegisterGuideView
                    if dtPassViewVisible {
                        Divider()
                        myDTPassView
                        Rectangle()
                            .foregroundColor(.white)
                            .frame(height: 90)
                    }
                }
                .onChange(of: focusField) { didChangeTextFieldFocus($0) }
            }
            bottomRegisterView
        }
        
    }
}
//MARK: - Preview
struct AddStarbucksCardView_Previews: PreviewProvider {
    static var previews: some View {
        AddStarbucksCardView()
        AddCardView(store: Store(initialState: .init(), reducer: { AddCardReducer() }))
    }
}
//MARK: - Configure Layout
private extension AddStarbucksCardView {
    /// 카드명과 텍스트필드, 가이드 문구를 포함한 뷰 입니다.
    var cardNameView: some View {
        VStack(alignment: .leading) {
            Text("카드명")
                .font(.caption2)
                .opacity(cardNameTitleVisible ? 1 : 0)
                .offset(y: cardNameTitleVisible ? -5 : 0)
                .animation(.easeIn, value: cardNameTitleVisible)
            TextField("", text: $cardNameText, prompt: Text(cardNamePlaceHolderText).foregroundColor(.black))
                .focused($focusField, equals: .cardName)
                .onTapGesture { focusField = .cardName }
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(didTappedCardNameTextField ? .green : .gray)
            Text("카드명은 미입력 시 자동으로 부여됩니다.")
                .foregroundColor(.gray)
                .font(.footnote)
        }
        .padding([.leading, .trailing], 10)
    }
    /// 카드번호와 가이드 문구를 포함한 뷰 입니다.
    var cardNumberView: some View {
        VStack(alignment: .leading) {
            Text("스타벅스 카드번호")
                .font(.caption2)
                .opacity(cardNumberTitleVisible ? 1 : 0)
                .offset(y: cardNumberTitleVisible ? -5 : 0)
                .animation(.easeIn, value: cardNumberTitleVisible)
            ZStack {
                HStack {
                    TextField("", text: $cardNumberText, prompt: Text(cardNumberPlaceHolderText).foregroundColor(.black))
                        .keyboardType(.numberPad)
                        .focused($focusField, equals: .cardNumber)
                        .onTapGesture { focusField = .cardNumber }
                    Image(systemName: "exclamationmark.triangle.fill")
                        .opacity(cardNumberUnderlineColor == .red ? 1 : 0)
                        .foregroundColor(.red)
                }
            }
            
            Rectangle()
                .frame(height: 0.5)
                .foregroundColor(cardNumberUnderlineColor)
            Text(cardNumberGuideText)
                .foregroundColor(cardNumberUnderlineColor)
                .frame(height: 20)
                .font(.footnote)
        }
        .padding([.leading, .trailing], 10)
    }
    /// 핀번호와 가이드 문구를 포함한 뷰 입니다.
    var pinNumberView: some View {
        VStack(alignment: .leading) {
            Text("Pin번호")
                .font(.caption2)
                .opacity(pinNumberTitleVisible ? 1 : 0)
                .offset(y: pinNumberTitleVisible ? -5 : 0)
                .animation(.easeIn, value: pinNumberTitleVisible)
            ZStack {
                HStack(spacing: 5) {
                    TextField("", text: $pinNumberText, prompt: Text(pinNumberPlaceHolderText).foregroundColor(.black))
                        .keyboardType(.numberPad)
                        .focused($focusField, equals: .pinNumber)
                        .onTapGesture { focusField = .pinNumber }
                    Image(systemName: "exclamationmark.triangle.fill")
                        .opacity(pinNumberUnderlineColor == .red ? 1 : 0)
                        .foregroundColor(.red)
                    Button {
                        didTappedPinNumberGuideButton.toggle()
                    } label: {
                        Image(systemName: "info.circle")
                            .foregroundColor(.gray)
                    }
                }
            }
            
            Rectangle()
                .frame(height: 0.5)
                .foregroundColor(pinNumberUnderlineColor)
            Text(pinNumberGuideText)
                .foregroundColor(pinNumberUnderlineColor)
                .frame(height: 20)
                .font(.footnote)
        }
        .padding([.leading, .trailing], 10)
        .sheet(isPresented: $didTappedPinNumberGuideButton) {
            CardRegisterGuideView()
        }
        .presentationDetents([.large])
        .presentationDragIndicator(.visible)
    }
    /// 카드등록을 위한 가이드 뷰 입니다.
    var cardRegisterGuideView: some View {
        Rectangle()
            .frame(height: 140)
            .foregroundColor(.gray.opacity(0.3))
            .overlay {
                VStack {
                    Text("스타벅스 카드 등록시, 실물 카드와 카드 바코드 모두 사용 가능합니다.\n카드가 없다면 e-Gift Card의 나에게 선물하기를 이용해보세요. 카드명은 미입력 시 자동으로 부여됩니다.")
                    Spacer()
                }
                .padding(10)
            }
            .padding([.leading, .trailing], 10)
    }
    /// My DT Pass View입니다. Section에 따라 header, content, footer로 구성되어 있습니다.
    var myDTPassView: some View {
        Section {
            myDTPassContentView
        } header: {
            Text("차량번호를 등록하시고, My DT Pass의 편리한 결제서비스를 만나보세요! (선택)")
                .padding([.leading, .trailing], 10)
        } footer: {
            HStack(spacing: 20) {
                Spacer()
                Text("카드 등록 시, My DT Pass 다시 보지 않기")
                Button {
                    dtPassAlertVisible.toggle()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.black.opacity(0.7))
                }
            }
            .padding([.leading, .trailing], 10)
        }
        .fullScreenCover(isPresented: $dtPassAlertVisible) {
            MyDTPassAlertView(isPresented: $dtPassAlertVisible,
                              dtPassViewVisible: $dtPassViewVisible)
                .presentationBackground(.gray.opacity(0.6))
        }
        .transaction { transaction in
            transaction.disablesAnimations = true
        }
    }
    /// My DT Pass 내부 컨텐츠 뷰 입니다.
    var myDTPassContentView: some View {
        VStack(alignment: .leading, spacing: 10) {
            /// My DT Pass Info
            Section {
                Text("My DT Pass란?")
                    .bold()
                Text("DT 매장 이용 시, 결제수단을 제시하지 않아도 간편하고 빠르게 결제할 수 있는 서비스 입니다.")
                //                .frame(height: 45)
                    .font(.callout)
                Divider()
                HStack {
                    Button {
                        didTappedFirstDTPassButton.toggle()
                        firstResponseSubject.send(didTappedFirstDTPassButton)
                    } label: {
                        if didTappedFirstDTPassButton {
                            RoundedRectangle(cornerRadius: 5, style: .circular)
                                .foregroundColor(.green)
                                .frame(width: 20, height: 20)
                                .overlay {
                                    Image(systemName: "checkmark")
                                        .resizable()
                                        .foregroundColor(.white)
                                        .frame(width: 10, height: 10)
                                        .bold()
                                }
                        } else {
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(lineWidth: 0.5)
                                .foregroundColor(.green)
                                .frame(width: 20, height: 20)
                        }
                    }
                    
                    Text("My DT Pass 이용약관 (필수)")
                        .font(.footnote)
                        .bold()
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                
                HStack {
                    Button {
                        didTappedSecondDTPassButton.toggle()
                        secondResponseSubject.send(didTappedSecondDTPassButton)
                    } label: {
                        if didTappedSecondDTPassButton {
                            checkedBox
                        } else {
                            unCheckedBox
                        }
                    }
                    Text("My DT Pass 개인정보 수집 및 이용동의 (필수)")
                        .font(.footnote)
                        .bold()
                    Spacer()
                    Image(systemName: "chevron.right")
                }
            }
            /// 차량 번호 입력 Section
            Section {
                Text("차량번호를 입력해 주세요. (필수)")
                Text("차량번호")
                    .font(.caption2)
                    .opacity(carNumberTitleVisible ? 1 : 0)
                    .offset(y: carNumberTitleVisible ? -5 : 0)
                    .animation(.easeIn, value: carNumberTitleVisible)
                ZStack {
                    HStack {
                        TextField("", text: $carNumberText, prompt: Text(carNumberPlaceHolderText).foregroundColor(.black))
                            .keyboardType(.numberPad)
                            .focused($focusField, equals: .car)
                            .onTapGesture { focusField = .car }
                        Image(systemName: "exclamationmark.triangle.fill")
                            .opacity(cardNumberUnderlineColor == .red ? 1 : 0)
                            .foregroundColor(.red)
                    }
                }
                Rectangle()
                    .frame(height: 0.5)
                    .foregroundColor(carNumberUnderlineColor)
                Text(carNumberGuideText)
                    .foregroundColor(carNumberUnderlineColor)
                    .frame(height: 20)
                    .font(.footnote)
                VStack(alignment: .leading, spacing: 5) {
                    Text("- 정확한 차량번호를 입력해 주세요.")
                    Text("- 신형 또는 구형 차량번호 모두 입력 가능합니다. \n  예) '12가1234', '서울12가1234'")
                    Text("- '-'를 제외한 특수문자 입력은 제한됩니다.")
                    Text("- 차량 소유주 변경 및 폐차 처리 시 반드시 차량번호를 해지해 주세요.")
                }
                .font(.footnote)
                .foregroundColor(.gray)
            }
            /// 차량 색상 입력 Section
            Section {
                Text("차량 색상을 선택해 주세요. (선택)")
                Rectangle()
                    .stroke(lineWidth: 1)
                    .foregroundColor(.gray)
                    .frame(height: 35)
                    .overlay {
                        HStack {
                            Text(selectedCarColor)
                                .font(.callout)
                                .foregroundColor(.black.opacity(0.7))
                            Spacer()
                            Rectangle()
                                .frame(width: 1, height: 20)
                                .foregroundColor(.black.opacity(0.3))
                            Image(systemName: "chevron.down")
                                .padding([.trailing], 3)
                        }
                        .padding(10)
                    }
                    .onTapGesture {
                        pickerVisible.toggle()
                    }
                    .sheet(isPresented: $pickerVisible) {
                        ZStack {
                            Color.black.opacity(0.1)
                            VStack(alignment: .trailing, spacing: 0) {
                                Button {
                                    pickerVisible.toggle()
                                } label: {
                                    Text("선택")
                                        .font(.title2)
                                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 5, trailing: 15))
                                        .foregroundColor(.green)
                                }
                                
                                Picker("", selection: $selectedCarColor) {
                                    ForEach(carColor, id: \.self) { fruit in
                                        Text(fruit)
                                    }
                                }
                                .background(.white)
                            }
                            .padding(.bottom, 30)
                            .pickerStyle(WheelPickerStyle())
                            .presentationDetents([.height(250)])
                            .interactiveDismissDisabled(true)
                        }
                    }
                Text("- 파트너가 고객님의 차량을 확인하고, 더욱 원활한 서비스 제공을 위해 사용됩니다.")
            }
            /// 저장하기
            Section {
                HStack {
                    Spacer()
                    Button {
                        //
                    } label: {
                        Capsule()
                            .frame(width: 130, height: 40)
                            .foregroundColor(.gray.opacity(0.3))
                            .overlay {
                                Text("저장하기")
                                    .foregroundColor(.white)
                            }
                    }
                    Spacer()
                }
            }
            
        }
        .padding(10)
        .background(.gray.opacity(0.3))
        .onReceive(firstResponseSubject.combineLatest(secondResponseSubject)) { response in
            let first = response.0
            let second = response.1
            carNumberPlaceHolderText =  first && second ? "차량번호" : "약관에 동의해주세요."
        }
    }
    /// 체크를 눌렀을 때 나타나는 뷰 입니다.
    var checkedBox: some View {
        RoundedRectangle(cornerRadius: 5, style: .circular)
            .foregroundColor(.green)
            .frame(width: 20, height: 20)
            .overlay {
                Image(systemName: "checkmark")
                    .resizable()
                    .foregroundColor(.white)
                    .frame(width: 10, height: 10)
                    .bold()
            }
    }
    /// 체크를 하지 않았을 때 나타나는 뷰 입니다.
    var unCheckedBox: some View {
        RoundedRectangle(cornerRadius: 5)
            .stroke(lineWidth: 0.5)
            .foregroundColor(.green)
            .frame(width: 20, height: 20)
    }
    /// 최하단 플로팅 뷰인 `등록` 뷰 입니다.
    var bottomRegisterView: some View {
        Rectangle()
            .frame(height: 90)
            .foregroundColor(.white)
            .shadow(radius: 1, x: -1, y: -2)
            .overlay {
                VStack(spacing: 0) {
                    HStack {
                        Button {
                            termButtonChecked.toggle()
                        } label: {
                            if termButtonChecked {
                                checkedBox
                                Text("스타벅스 카드 이용약관 동의 [필수]")
                                Spacer()
                                Image(systemName: "chevron.right")
                            } else {
                                unCheckedBox
                                Text("스타벅스 카드 이용약관 동의 [필수]")
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                        }
                        .foregroundColor(.black)
                    }
                    .padding(.top, 10)
                    Spacer()
                    Button {
                        //
                    } label: {
                        Capsule()
                            .frame(height: 40)
                            .foregroundColor(registerButtonActiveCheck() ? .green : .gray.opacity(0.4))
                            .overlay {
                                Text("등록하기")
                                    .foregroundColor(.white)
                            }
                            .padding(.bottom, 10)
                    }
                    .disabled(registerButtonActiveCheck() ? false : true)
                }
                .padding([.leading, .trailing], 10)
            }
    }
}
//MARK: - Helper
private extension AddStarbucksCardView {
    /// TextField의 Focus가 변경되었을 때 호출되는 함수입니다.
    func didChangeTextFieldFocus(_ focusField: Field?) {
        guard let focusType = focusField else { return }
        switch focusType {
        case .cardName:
            /// 1. 카드이름 관련 설정 (cardName)
            cardNamePlaceHolderText = ""
            didTappedCardNameTextField = true
            cardNameTitleVisible = true
            
            /// 2. 카드번호 관련 설정 (cardNumber)
            cardNumberFocusTrigger()
            
            /// 3. 핀번호 관련 설정 (pinNumber)
            pinNumberFocusTrigger()
            
        case .cardNumber:
            /// 1. 카드이름 관련 설정 (cardName)
            cardNameFocusTrigger()
            
            /// 2. 카드번호 관련 설정 (cardNumber)
            cardNumberPlaceHolderText = ""
            cardNumberGuideText = ""
            cardNumberUnderlineColor = .green
            cardNumberTitleVisible = true
            
            /// 3. 핀번호 관련 설정 (pinNumber)
            pinNumberFocusTrigger()
            
        case .pinNumber:
            /// 1. 카드이름 관련 설정 (cardName)
            cardNameFocusTrigger()
            
            /// 2. 카드번호 관련 설정 (cardNumber)
            cardNumberFocusTrigger()
            
            /// 3. 핀번호 관련 설정 (pinNumber)
            pinNumberPlaceHolderText = ""
            pinNumberGuideText = ""
            pinNumberUnderlineColor = .green
            pinNumberTitleVisible = true
            
        case .car:
            carNumberPlaceHolderText = ""
            carNumberTitleVisible = true
            carNumberUnderlineColor = .green
        }
    }
    /// didChangeTextFieldFocus에서 호출되는 내부 함수입니다. cardName 설정 시 호출됩니다.
    func cardNameFocusTrigger() {
        cardNamePlaceHolderText = cardNameText.isEmpty ? "카드명 최대 20자 (선택)" : ""
        didTappedCardNameTextField = false
        cardNameTitleVisible = cardNameText.isEmpty ? false : true
    }
    /// didChangeTextFieldFocus에서 호출되는 내부 함수입니다. cardNumber 설정 시 호출됩니다.
    func cardNumberFocusTrigger() {
        cardNumberPlaceHolderText = cardNumberText.isEmpty ? "스타벅스 카드번호 16자리 (필수)" : ""
        cardNumberTitleVisible = cardNumberText.isEmpty ? false : true
        
        if cardNumberText.isEmpty {
            cardNumberUnderlineColor = .gray
            cardNumberGuideText = ""
            
        } else {
            cardNumberUnderlineColor = numberValidCheck(cardNumberText, 16) ? .gray : .red
            cardNumberGuideText = numberValidCheck(cardNumberText, 16) ? "" : "올바른 스타벅스 카드번호를 입력해주세요"
        }
    }
    /// didChangeTextFieldFocus에서 호출되는 내부 함수입니다. pinNumber 설정 시 호출됩니다.
    func pinNumberFocusTrigger() {
        pinNumberPlaceHolderText = pinNumberText.isEmpty ? "Pin번호 8자리 (필수)" : ""
        pinNumberTitleVisible = pinNumberText.isEmpty ? false : true
        
        if pinNumberText.isEmpty {
            pinNumberUnderlineColor = .gray
            pinNumberGuideText = ""
        } else {
            pinNumberUnderlineColor = numberValidCheck(pinNumberText, 8) ? .gray : .red
            pinNumberGuideText = numberValidCheck(pinNumberText, 8) ? "" : "올바른 Pin번호를 입력해주세요"
        }
    }
    /// 카드번호가 입력받은 자릿수로 이루어진 숫자인지 확인하는 함수입니다.
    func numberValidCheck(_ text: String, _ number: Int) -> Bool {
        let regexPattern = "^[0-9]{\(number)}$"
        return text.range(of: regexPattern, options: .regularExpression) != nil
    }
    
    func registerButtonActiveCheck() -> Bool {
        return !cardNumberText.isEmpty && !pinNumberText.isEmpty && termButtonChecked
    }
}
