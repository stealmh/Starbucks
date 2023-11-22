//
//  Home.swift
//  Starbucks
//
//  Created by mino on 2023/10/25.
//

import ComposableArchitecture
import SwiftUI

struct Home: View {
    @Environment(\.colorScheme) var scheme
    private let store: StoreOf<HomeReducer>
    @ObservedObject var viewStore: ViewStoreOf<HomeReducer>
    
    init(store: StoreOf<HomeReducer>) {
        self.store = store
        viewStore = ViewStore(self.store, observe: { $0 })
    }
}
//MARK: - View
extension Home {
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    
                    LazyVStack(alignment: .center,
                               pinnedViews: .sectionHeaders){
                        
                        Section {
                            homeGeometryHelper
                            homeTopSectionView
                        }
                        
                        Section(header: homeStickyHeader) {
                            homeEventListView
                        }
                        
                        Section {
                            configureDefaultSectionHeader("고객님을 위한 추천 메뉴")
                            recommendMenuItem
                        }
                        
                        Section {
                            configureDefaultSectionHeader("하루가 달콤해지는 디저트")
                            recommendMenuItem
                        }
                        
                        Section {
                            noticeSectionHeader
                            noticeSectionItem
                        }
                        
                        Section {
                            homeEventListView
                        }
                        
                    }
                }
                .overlay(
                    (scheme == .dark ? Color.black : Color.white)
                        .frame(height: UIApplication.shared.windows.first?.safeAreaInsets.top)
                        .ignoresSafeArea(.all, edges: .top)
                        .opacity(viewStore.offset > 190 ? 1 : 0)
                    ,alignment: .top
                )
                deleveryButton
            }
        }
    }
}
//MARK: - Preview
struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home(store: Store(initialState: .init(), reducer: { HomeReducer() }))
    }
}
//MARK: -
extension Home {
    /// 스크롤에 따른 offset 위치를 체크하기 위한 geometryReader 입니다.
    private var homeGeometryHelper: some View {
        GeometryReader { reader -> AnyView in
            let offset = reader.frame(in: .global).minY
            if -offset > 0 {
                DispatchQueue.main.async {
                    //                    self.viewModel.offset = -offset
                    viewStore.send(.getOffset(-offset))
                }
            }
            return AnyView(Text("").frame(width: 0, height: 0))
        }
    }
    /// 최상단 이미지와 progressbar stack까지 포함하는 뷰입니다.
    private var homeTopSectionView: some View {
        VStack {
            Image("food")
                .resizable()

            VStack(alignment: .leading) {
                Text("15 ★ until Gold Level")
                    .foregroundColor(.green)
                HStack {
                    ProgressView("", value: viewStore.progressbarPercent, total: 100)
                        .padding(.trailing, 5)
                        .tint(.green)
                        .animation(.easeInOut(duration: 2), value: viewStore.progressbarPercent)
                    Text("10")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                    Text("/")
                        .foregroundColor(.gray)
                    Text("25★")
                        .font(.title3)
                        .foregroundColor(.green)
                        .padding(.trailing, 25)
                }
                .onAppear { viewStore.send(.onAppear) }
            }
            .padding(.leading, 25)
            .padding(.top, 10)
        }
        .frame(height: 220)
        .background(.white)
        .opacity(viewStore.offset > 150 ? 0 : 1)
        .animation(.easeOut, value: viewStore.offset)
    }
    /// 알림정보, 쿠폰 등 section의 Header로 사용되는 뷰 입니다.
    private var homeStickyHeader: some View {
        VStack {
            HStack {
                Button {
                    viewStore.send(.whatsNewButtonTapped)
                } label: {
                    whatsNewLabel
                }
                .padding(.trailing, 20)
                
                Button {
                    viewStore.send(.couponButtonTapped)
                } label: {
                    couponLabel
                }
                
                Spacer()
                Button {
                    viewStore.send(.noticeButtonTapped)
                } label: {
                    noticeLabel
                }
            }
            .navigationDestination(store: self.store.scope(state: \.$destination, action: {  .destination($0)}), state: /HomeReducer.Destination.State.notice, action: HomeReducer.Destination.Action.notice, destination: { store in
                NoticeView(store: store)
            })
            .navigationDestination(store: self.store.scope(state: \.$destination, action: {  .destination($0)}), state: /HomeReducer.Destination.State.coupon, action: HomeReducer.Destination.Action.coupon, destination: { store in
                CouponView(store: store)
            })
            .navigationDestination(store: self.store.scope(state: \.$destination, action: {  .destination($0)}), state: /HomeReducer.Destination.State.whatsNew, action: HomeReducer.Destination.Action.whatsNew, destination: { store in
                WhatsNewView(store: store)
            })
            .frame(height: 40)
            .padding([.leading, .trailing], 20)
            Divider()
        }
        .background(.white)
    }
    /// [WhatsNew] 'homeStickyHeader'의 내부 버튼의 label을 위해서 사용되는 뷰입니다.
    private var whatsNewLabel: some View {
        HStack {
            Image(systemName: "envelope")
                .resizable()
                .frame(width: 30, height: 20)
                .foregroundColor(.black).opacity(0.5)
            Text("What's New")
                .foregroundColor(.black)
                .font(.subheadline)
        }
    }
    /// [Coupon] 'homeStickyHeader'의 내부 버튼의 label을 위해서 사용되는 뷰입니다.
    private var couponLabel: some View {
        HStack {
            Image(systemName: "creditcard")
                .resizable()
                .frame(width: 30, height: 20)
                .foregroundColor(.black).opacity(0.5)
            Text("Coupon")
                .foregroundColor(.black)
                .font(.subheadline)
        }
    }
    /// [Notice] 'homeStickyHeader'의 내부 버튼의 label을 위해서 사용되는 뷰입니다.
    private var noticeLabel: some View {
        Image(systemName: "bell")
            .resizable()
            .frame(width: 20, height: 20)
            .foregroundColor(.black).opacity(0.5)
    }
    /// 사진 공지사항 리스트를 보여주는 뷰 입니다.
    private var homeEventListView: some View {
        VStack(alignment: .center, spacing: 10, content: {
            
            ForEach(viewStore.foodList, id: \.self) { foodName in
                Image(foodName)
                    .resizable()
                    .frame(height: foodName == "sandwich" ? 300 : 180)
            }
            
        })
        .padding([.leading, .trailing], 10)
        .padding(.bottom, 40)
    }
    /// Label과 button이 있는 Section Header 입니다.
    private var noticeSectionHeader: some View {
        HStack {
            Text("What's New")
                .font(.title2)
                .bold()
            Spacer()
            Button("See all") {
                
            }
            .foregroundColor(.green)
        }.padding([.leading, .trailing], 20)
    }
    /// 수평스크롤이 가능한 noticeSection 전용 뷰 입니다.
    private var noticeSectionItem: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(viewStore.noticeList, id: \.self) { list in
                    VStack(alignment: .leading) {
                        Image(list.thumbnail)
                            .resizable()
                            .cornerRadius(5)
                        Spacer()
                        Text(list.title)
                            .font(.title3)
                            .bold()
                            .lineLimit(1)
                            .padding(.top, 10)
                        Text(list.contents)
                            .foregroundColor(.black).opacity(0.6)
                            .lineLimit(2)
                    }
                    // CardView(item: notice)
                }
                .padding(.trailing, 10)
                .padding(.top, 30)
            }
            .frame(width: 800, height: 250)
            //                            .padding(.trailing, 20)
        }
        .padding(.leading, 20)
        .padding(.bottom, 40)
        .frame(height: 250)
    }
    /// 수평스크롤이 가능한 음료, 디저트 추천 뷰 입니다.
    private var recommendMenuItem: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(viewStore.recommendCoffee) { list in
                    VStack(alignment: .center) {
                        Image(list.coffeeImage)
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: 135, height: 135)
                            .padding(.top, 10)
                        Text(list.title)
                            .frame(width: 135, height: 45)
                            .lineLimit(2)
                    }
                    .padding(.top, 25)
                }
                .padding([.leading], 20)
            }
            .frame(height: 250)
        }
        .padding(.bottom, 40)
        .frame(height: 250)
    }
    /// Label만 존재하는 Section Title입니다.
    private func configureDefaultSectionHeader(_ title: String) -> some View {
        return HStack {
            Text(title)
                .font(.title2)
                .bold()
            Spacer()
        }.padding(.leading, 20)
    }
    /// 우측 하단의 배달 버튼
    private var deleveryButton: some View {
        VStack {
            Spacer()
            HStack(alignment: .center) {
                Spacer()
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(.green)
                        .frame(width: viewStore.deleveryButtonSize, height: 70)
                        .padding(.trailing, 10)
                        .overlay {
                            Image(systemName: "heart")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .padding(.trailing, viewStore.scrollUp ? 10 : 140)
//                                .padding(25)
                            Text("Delevery")
                                .font(.title)
                                .opacity(viewStore.scrollUp ? 0 : 1)
                                .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 0))
                        }
                        .foregroundColor(.white)

//                    Image(systemName: "heart")
//                        .padding(25)
//                    Text("text")
//                        .padding(.leading, 90)
                    
                }
                .animation(.easeIn, value: viewStore.deleveryButtonSize)
            }
        }
    }
}
