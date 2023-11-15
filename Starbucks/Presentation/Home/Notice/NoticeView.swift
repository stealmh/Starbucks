//
//  NoticeView.swift
//  Starbucks
//
//  Created by mino on 2023/10/25.
//

import SwiftUI

struct NoticeView: View {
    @StateObject private var viewModel: NoticeViewModel = NoticeViewModel()
    private let title: String = "알림"
    
    var body: some View {
        ZStack {
            ScrollView {
                ZStack(alignment: .topLeading) {
                    LazyVStack {
                        menuHeaderView(viewModel.menuCase)
                        noticeListView
                    }
                    menuSelectView
                }
                loadingView
            }
            .background(viewModel.reviewPopupPresented ? .gray.opacity(0.6) : .white)
            
            if viewModel.reviewPopupPresented {
                ReviewWritePopupView(isPresented: $viewModel.reviewPopupPresented,
                                     style: $viewModel.popupStyle,
                                     viewModel: viewModel)
            }
        }
        .animation(.easeInOut, value: viewModel.reviewPopupPresented)
        .scrollDisabled(viewModel.reviewPopupPresented ? true : false)
        .navigationSetting(viewModel: viewModel, title)
    }
}
//MARK: - Preview
struct NoticeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            NoticeView()
        }
    }
}
//MARK: - Configure Layout
extension NoticeView {
    /// 'header'를 눌렀을 때 나오는 메뉴 선택 뷰 입니다.
    private var menuSelectView: some View {
        VStack(alignment: .center, spacing: 0) {
            ForEach(NoticeCase.allCases, id: \.self) { menu in
                Text(menu.title)
                    .fontWeight(.semibold)
                    .frame(width: 156, height: 43.3)
                    .background(viewModel.menuCase == menu ? .gray.opacity(0.3) : .white)
                    .padding(.top, 10)
                    .onTapGesture {
                        viewModel.isLoading = true
                        viewModel.menuCase = menu
                        viewModel.menuListButtonToogle.toggle()
                    }
            }
        }
        .frame(width: 156)
        .background(.white)
        .cornerRadius(10)
        .padding(.leading, 20)
        .shadow(radius: 5)
        .opacity(viewModel.menuListButtonToogle ? 1 : 0)
    }
    /// 알림 리스트입니다.
    private var noticeListView: some View {
        ForEach(viewModel.filterNotice) { data in
            noticeItem(data)
                .padding([.leading, .trailing, .top], 10)
                .onTapGesture { viewModel.itemTapGesture(data.id) }
            if let detail = data.detail, detail.isOpen {
                noticeDetailItem(detail)
            }
        }
        .onChange(of: viewModel.menuCase) { viewModel.menuCaseDidChange($0) }
        //.transition(.slide)
        //.animation(.easeIn(duration: 0.2))
    }
    /// 간단한 로딩뷰로 정중앙에 위치합니다.
    private var loadingView: some View {
        HStack(alignment: .center) {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .padding(.top, 10)
        }
        .opacity(viewModel.isLoading ? 1 : 0)
    }
    /// 메뉴의 헤더입니다.
    private func menuHeaderView(_ itemCase: SqaureBoxLayer) -> some View {
        ZStack {
            VStack(alignment: .leading) {
                HStack {
                    Text(itemCase.title)
                    Spacer()
                    Image(systemName: "chevron.down")
                }
                .foregroundColor(.black)
                Divider()
            }
            .background(.clear)
            .padding([.leading, .trailing], 20)
            .padding(.top, 20)
            .onTapGesture {
                viewModel.menuListButtonToogle.toggle()
            }
        }
    }
    /// 항목을 보여주는 아이템 입니다.
    private func noticeItem(_ item: NoticeModel) -> some View {
        HStack {
            Image(systemName: item.noticeType.imageName)
                .resizable(resizingMode: .stretch)
                .frame(width: 30, height: 30)
                .padding(10)
            VStack(alignment: .leading) {
                Text(item.noticeTitle)
                Text(item.noticeTime)
                    .foregroundColor(.gray)
            }
            Spacer()
            if let detail = item.detail {
                // 1. detail이 있으면서 열려있다면 right / 닫혀있다면 down
                Image(systemName: detail.isOpen ? "chevron.right" : "chevron.down")
                    .padding(.trailing, 5)
            } else {
                Image(systemName: "chevron.right")
                .padding(.trailing, 5)
            }
        }
    }
    /// 항목의 셀을 터치했을 때 보여지는 아이템입니다.
    private func noticeDetailItem(_ item: NoticeDetailModel) -> some View {
        HStack {
            Image(systemName: item.noticeType)
                .resizable(resizingMode: .stretch)
                .frame(width: 30, height: 30)
                .padding(10)
            VStack(alignment: .leading) {
                Text(item.noticeTitle)
                Text(item.noticeTime)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding(20)
        .background(.gray.opacity(0.05))
    }
}
//MARK: - Configure NavigationBar
fileprivate extension View {
    func navigationSetting(viewModel: NoticeViewModel, _ title: String) -> some View {
        self
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.large)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: BackbuttonOnlyIcon())
            .toolbar {
                Button {
                    viewModel.popupStyle = .deleteMessage
                    viewModel.reviewPopupPresented.toggle()
                } label: {
                    Image(systemName: "trash")
                }
                .foregroundColor(.black.opacity(0.5))
            }
    }
}

