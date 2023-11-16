//
//  OtherView.swift
//  Starbucks
//
//  Created by mino on 2023/10/25.
//

import SwiftUI

struct OtherView: View {
    @State private var nickname = "ALSGH309"
    private let title = "Other"
    let gridItems = Array(repeating: GridItem(.flexible()), count: 3)
    let sectionItems = Array(repeating: GridItem(.flexible()), count: 2)
    let gridContent = QuickMenu.mock
    let sectionContent = MultiSection.mock
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                let width = geo.size.width
                ScrollView {
                        VStack {
                            Divider()
                                .frame(height: 0.2)
                                .background(.gray.opacity(0.1))
                                .shadow(color: .black, radius: 2, x: 0, y: 2)
                            
                            welcomeView
                            
                            LazyVGrid(columns: gridItems, spacing: 10) {
                                quickMenuForEach(item: gridContent, superViewSize: geo)
                            }
                            .padding([.leading, .trailing], 10)
                            
                            sinsegyeAd
                                .frame(width: width, height: width * 0.2 + 10)
                            
                            multiSectionForEach(item: sectionContent, superViewSize: geo)
                            Button {
                                /// logout action
                            } label: {
                                logoutViewLayout
                            }

                        }
                        .embedInZStackForColor(.gray, 0.05)
                        .navigationTitle(title)
                        .toolbar { otherViewToolbar }
                }
            }
        }
    }
}

//MARK: - Preview
struct OtherView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            OtherView()
        }
    }
}
//MARK: - Configure Layout
extension OtherView {
    /// 닉네임과 환영 문구 UI
    var welcomeView: some View {
        VStack {
            HStack {
                Text(nickname.maskedID)
                    .bold()
                    .foregroundColor(.green)
                Text("님")
            }
            .padding(.top, 30)
            Text("환영합니다! 🙌🏻")
        }
    }
    /// 상단 우측 툴바 Layout
    var otherViewToolbar: some View {
        HStack {
            NavigationLink {
                NoticeView()
            } label: {
                Image(systemName: "bell")
                    .padding(.trailing, 10)
            }

            Button {
                // setting
            } label: {
                Image(systemName: "gearshape")
            }
        }
        .foregroundColor(.black.opacity(0.7))
        .padding([.trailing, .top], 10)
    }
    /// QuickMenu아래의 광고버튼
    var sinsegyeAd: some View {
        ZStack {
            Rectangle()
                .cornerRadius(20)
                .foregroundColor(.white)
                .shadow(radius: 3)
            HStack {
                Rectangle()
                    .frame(width: 60, height: 50)
                    .padding(.leading, 20)
                VStack(alignment: .leading) {
                    Text("멤버십 혜택의 신세계")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text("신세계 유니버스 클럽 가입")
                        .bold()
                }
                .padding(.leading, 5)
                Spacer()
            }
        }
        .padding([.leading, .trailing], 15)
        .padding(.top, 10)
        
    }
    /// 로그아웃 UI 구성
    var logoutViewLayout: some View {
        VStack {
            Text("로그아웃")
            Rectangle()
                .frame(height: 1)
                .offset(y: -14)
        }
        .frame(width: 60)
        .foregroundColor(.gray)
    }
    /// 6개 메뉴 버튼 Layout
    func quickMenuForEach(item: [QuickMenu], superViewSize: GeometryProxy) -> some View {
        return ForEach(item) { content in
            let empty = content.title.isEmpty
                ZStack {
                    Rectangle()
                        .frame(width: superViewSize.size.width * 0.28, height: superViewSize.size.width * 0.28)
                        .cornerRadius(20)
                        .foregroundColor(.white)
                        .shadow(radius: 3)
                    VStack(alignment: .center) {
                        Image(systemName: content.image)
                            .resizable()
                            .frame(width: 30, height: 30)
                            .padding(.top, 10)
                            .foregroundColor(.green)
                        Text(content.title)
                            .fontWeight(.semibold)
                    }
                }
            .opacity(empty ? 0 : 1)
        }
        .frame(width: superViewSize.size.width * 0.3, height: superViewSize.size.width * 0.3)
    }
    /// Pay, Order 등.. MultiSection 대응
    func multiSectionForEach(item: [MultiSection], superViewSize: GeometryProxy) -> some View {
        return ForEach(item) { content in
            Section {
                LazyVGrid(columns: sectionItems) {
                    ForEach(content.detail) { detail in
                        
                        NavigationLink {
                            
                        } label: {
                            HStack {
                                Image(systemName: detail.image)
                                Text(detail.contentLabel)
                                Spacer()
                            }
                            .padding([.leading, .trailing], 25)
                            .frame(width: superViewSize.size.width / 2)
                            .foregroundColor(.black.opacity(0.8))
                            .padding([.top, .bottom], 20)
                        }
                    }
                }
            } header: {
                sectionHeader(section: content.section)
            } footer: {
                sectionFooter(section: content.section)
            }
        }
    }
    /// MultiSection의 Header를 구성합니다.
    func sectionHeader(section: MultiSection.MultiSectionCase) -> some View {
        return HStack {
            Text(section.title)
                .font(.title2)
                .fontWeight(.semibold)
            Spacer()
        }
        .padding(.leading, 25)
        .padding(.top, 30)
    }
    /// MultiSection의 Footer를 구성합니다.
    func sectionFooter(section: MultiSection.MultiSectionCase) -> some View {
        switch section {
        case .pay: return AnyView(Divider())
        case .order: return AnyView(Divider())
        case .shop: return AnyView(Divider())
        case .delivers: return AnyView(Divider())
        case .customerSupport: return AnyView(EmptyView())
        }
    }
}

//MARK: - Helper
private extension String {
    var maskedID: String {
        guard self.count >= 2 else { return self }
        let endIndex = self.index(self.endIndex, offsetBy: -2)
        let maskedPart = String(repeating: "*", count: 2)
        let maskedString = self.prefix(upTo: endIndex) + maskedPart
        return String(maskedString)
    }
}
