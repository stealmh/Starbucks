//
//  WhatsNewView.swift
//  Starbucks
//
//  Created by mino on 2023/10/25.
//

import SwiftUI

struct WhatsNewView: View {
    @State private var menuCase: MenuCase = .all
    @State private var menuListButtonToggle: Bool = false
    @State private var loading = false
    @StateObject var viewModel = WhatsNewViewModel()
    private let title: String = "What's New"
    private let testing: Bool = false
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .topLeading) {
                LazyVStack {
                        menuListCard(menuCase)
                        if loading {
                            loadingIndicator()
                        } else {
                            ForEach(viewModel.movieList, id: \.a) { movie in
                                WhatsNewCell(title: "\(movie.id ?? 0)")
                                    .onAppear { viewModel.infiniteScroll(movieItem: movie) }
                            }
                            if viewModel.movieList.isEmpty {
                                Text("새로운 메시지가 없습니다")
                            }
                        }
                    }
                
                menuListDetailCard
            }
        }
        .navigationSetting(title)
        .onChange(of: menuCase, perform: { newValue in
            viewModel.movieList = []
            loading = true
            Task {
                try await Task.sleep(nanoseconds: 1 * 1_000_000_000) /// 네트워크 통신
                loading = false
            }
        })
        .onAppear {
            if !testing {
                Task {
                    let a = try await viewModel.request(type: Movie.self)
                    _ = a.results.map { viewModel.movieList.append($0) }
                }
            }
        }
    }
}
//MARK: - Preview
struct WhatsNewView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            WhatsNewView()
        }
    }
}
//MARK: -
extension WhatsNewView {
    
    func menuListCard(_ itemCase: SqaureBoxLayer) -> some View {
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
            .background(.white)
            .padding([.leading, .trailing], 20)
            .padding(.top, 20)
            .onTapGesture {
                menuListButtonToggle.toggle()
            }
        }
    }
    
    private var menuListDetailCard: some View {
        VStack(alignment: .center, spacing: 0) {
            ForEach(MenuCase.allCases, id: \.self) { menu in
                Text(menu.title)
                    .fontWeight(.semibold)
                    .frame(width: 156, height: 43.3)
                    .background(menuCase == menu ? .gray.opacity(0.3) : .white)
                    .padding(.top, 10)
                    .onTapGesture {
                        menuCase = menu
                        menuListButtonToggle.toggle()
                    }
            }
        }
        .frame(width: 156)
        .background(.white)
        .cornerRadius(10)
        .padding(.leading, 20)
        .shadow(radius: 5)
        .opacity(menuListButtonToggle ? 1 : 0)
    }
    
    func loadingIndicator() -> some View {
        return VStack {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .padding(.top, 10)
        }
    }
}

fileprivate extension View {
    func navigationSetting(_ title: String) -> some View {
        self
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.large)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: BackbuttonOnlyIcon())
    }
}

