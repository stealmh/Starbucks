//
//  WhatsNewView.swift
//  Starbucks
//
//  Created by mino on 2023/10/25.
//

import ComposableArchitecture
import SwiftUI

struct WhatsNewView: View {
    private let title: String = "What's New"
    
    let store: StoreOf<WhatsNewReducer>
    @ObservedObject var viewStore: ViewStoreOf<WhatsNewReducer>
    
    init(store: StoreOf<WhatsNewReducer>) {
        self.store = store
        self.viewStore = ViewStore(self.store, observe: { $0 })
    }
}
//MARK: - View
extension WhatsNewView {
    var body: some View {
        ScrollView {
            ZStack(alignment: .topLeading) {
                LazyVStack {
                    menuListCard(viewStore.menuCase)
                    if viewStore.loading {
                            loadingIndicator()
                        } else {
                            ForEach(viewStore.movieList) { movie in
                                WhatsNewCell(title: "\(movie.id ?? 0)")
                                    .onAppear { viewStore.send(.scrollIsEnd(movie)) }
                            }
                            if viewStore.movieList.isEmpty {
                                Text("새로운 메시지가 없습니다")
                            }
                        }
                    }
                
                menuListDetailCard
            }
        }
        .navigationSetting(title)
        .onAppear { viewStore.send(.onAppear) }
    }
}
//MARK: - Preview
struct WhatsNewView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            WhatsNewView(store: Store(initialState: .init(), reducer: { WhatsNewReducer() }))
        }
    }
}
//MARK: - Configure Layout
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
            .onTapGesture { viewStore.send(.menuButtonTapped) }
        }
    }
    
    private var menuListDetailCard: some View {
        VStack(alignment: .center, spacing: 0) {
            ForEach(MenuCase.allCases, id: \.self) { menu in
                Text(menu.title)
                    .fontWeight(.semibold)
                    .frame(width: 156, height: 43.3)
                    .background(viewStore.menuCase == menu ? .gray.opacity(0.3) : .white)
                    .padding(.top, 10)
                    .onTapGesture { viewStore.send(.menuDetailButtonTapped(menu)) }
            }
        }
        .frame(width: 156)
        .background(.white)
        .cornerRadius(10)
        .padding(.leading, 20)
        .shadow(radius: 5)
        .opacity(viewStore.menuListButtonToggle ? 1 : 0)
    }
    
    func loadingIndicator() -> some View {
        return VStack {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .padding(.top, 10)
        }
    }
}
//MARK: - NavigationSetting
fileprivate extension View {
    func navigationSetting(_ title: String) -> some View {
        self
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.large)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: BackbuttonOnlyIcon())
    }
}

