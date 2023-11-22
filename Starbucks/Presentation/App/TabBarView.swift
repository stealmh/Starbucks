//
//  TabBarView.swift
//  Starbucks
//
//  Created by mino on 2023/10/18.
//

import ComposableArchitecture
import SwiftUI

struct TabBarView: View {
    private let store: StoreOf<RootReducer>
    @ObservedObject var viewStore: ViewStoreOf<RootReducer>
    
    init(store: StoreOf<RootReducer>) {
        self.store = store
        viewStore = ViewStore(self.store, observe: { $0 })
    }

    var body: some View {
        IfLetStore(store.scope(state: \.welcom, action: {.welcome($0)})) {
            StartingPopupView(store: $0)
        } else: {
            tabbarView
        }
    }
}
//MARK: - Preview
struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            TabBarView(
                store: StoreOf<RootReducer>(
                    initialState:.init(),
                    reducer: { RootReducer()._printChanges() }
                )
            )
        }
    }
}
//MARK: - Configure Layout
extension TabBarView {
    
    var tabbarView: some View {
        ZStack {
            switch viewStore.isLoading {
            case true:
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .frame(width: 50, height: 50)
            case false:
                TabView(selection: viewStore.binding(get: \.selectedTab, send: RootReducer.Action.tabSelected)) {
                    
                    Home(store: self.store.scope(state: \.home, action: RootReducer.Action.home))
                        .tabItem {
                                Image(systemName: "house.fill")
                                Text("홈")
                        }
                        .tag(RootReducer.Tab.home)
                    
                    PayView(store: self.store.scope(state: \.pay, action: RootReducer.Action.pay))
                        .tabItem {
                            Image(systemName: "creditcard.fill")
                            Text("Pay")
                        }
                        .tag(RootReducer.Tab.pay)
                    
                    OrderView(store: self.store.scope(state: \.order, action: RootReducer.Action.order))
                        .tabItem {
                            Image(systemName: "cup.and.saucer")
                            Text("Order")
                        }
                        .tag(RootReducer.Tab.order)
                    
                    ShopView(store: self.store.scope(state: \.shop,
                                                     action: RootReducer.Action.shop))
                        .tabItem {
                            Image(systemName: "cart")
                            Text("Shop")
                        }
                        .tag(RootReducer.Tab.shop)
                    
                    OtherView(store: self.store.scope(state: \.other, action: RootReducer.Action.other))
                        .tabItem {
                            Image(systemName: "ellipsis")
                            Text("Other")
                        }
                        .tag(RootReducer.Tab.other)
                }
                .accentColor(.green)
            }
        }
        .onAppear {
            viewStore.send(.onAppear)
        }
    }
}
