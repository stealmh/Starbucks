//
//  CouponInfoView.swift
//  Starbucks
//
//  Created by DEV IOS on 2023/11/15.
//

import ComposableArchitecture
import SwiftUI

struct CouponInfoView: View {
    private let title = "쿠폰 이용안내"
//    @StateObject private var viewModel = CouponInfoViewModel()
    let store: StoreOf<CouponInfoReducer>
    @ObservedObject var viewStore: ViewStoreOf<CouponInfoReducer>
    
    init(store: StoreOf<CouponInfoReducer>) {
        self.store = store
        self.viewStore = ViewStore(self.store, observe: { $0 })
    }
}
//MARK: - View
extension CouponInfoView {
    var body: some View {
        VStack {
            Text("(실제로는 자기네들 온보딩 들어감)")
            ZStack {
                TabView(selection: viewStore.$currentPage) {
                    ForEach(InfoPaging.allCases, id: \.self) { trip in
                        Rectangle()
                            .foregroundColor(trip.color)
                            .frame(height: 450)
                            .clipShape(RoundedRectangle(cornerRadius: 25.0))
                            .padding(.horizontal, 20)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                HStack {
                    preNextButton(type: .previous, systemName: "chevron.backward")
                    Spacer()
                    preNextButton(type: .next, systemName: "chevron.forward")
                }
                .opacity(viewStore.buttonHidden ? 0 : 1)
                .padding([.leading, .trailing], 20)
            }
        }
        .navigationSetting(title)
        .onTapGesture { viewStore.send(.viewDidTapped) }
        .onAppear { viewStore.send(.onAppear) }
        .onDisappear { viewStore.send(.onDisappear) }
    }
}

//MARK: - Preview
struct CouponInfoView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CouponInfoView(store: Store(initialState: .init(), reducer: { CouponInfoReducer()._printChanges() }))
        }
    }
}
//MARK: - Configure NavigationBar
fileprivate extension View {
    func navigationSetting(_ title: String) -> some View {
        self
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(title)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: BackbuttonOnlyIcon())
            .toolbar(.hidden, for: .tabBar)
    }
}
//MARK: - Configure Layout
extension CouponInfoView {
    private func preNextButton(type: PreNextButtonType, systemName: String) -> some View {
        Button {
//            viewModel.preNextButtonTapped(type: type)
            viewStore.send(.preNextButtonTapped(type))
        } label: {
            ZStack {
                Circle()
                    .fill(Constants.preNextButtonColor)
                    .frame(width: Constants.preNextButtonWidth,
                           height: Constants.preNextButtonHeight)
                    .overlay {
                        Image(systemName: systemName)
                            .resizable()
                            .frame(width: Constants.preNextButtonInsideImageWidth,
                                   height: Constants.preNextButtonInsideImageHeight)
                            .foregroundColor(Constants.preNextButtonInsideImageColor)
                    }
            }
        }
    }
}
//MARK: - Constants
private extension CouponInfoView {
    /// 'CouponInfoView' 모든 컴포넌트 사이즈 및 컬러 조정
    enum Constants {
        ///버튼의 배경색
        static let preNextButtonColor: Color = .gray
        ///버튼의 너비
        static let preNextButtonWidth: CGFloat = 50
        ///버튼의 높이
        static let preNextButtonHeight: CGFloat = 50
        ///버튼 내부 이미지의 너비
        static let preNextButtonInsideImageWidth: CGFloat = 10
        ///버튼 내부 이미지의 높이
        static let preNextButtonInsideImageHeight: CGFloat = 15
        ///버튼 내부 이미지의 색
        static let preNextButtonInsideImageColor: Color = .white
    }
}
