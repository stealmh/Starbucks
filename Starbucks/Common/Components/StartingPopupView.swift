//
//  StartingPopupView.swift
//  Starbucks
//
//  Created by mino on 2023/11/15.
//

import ComposableArchitecture
import SwiftUI

struct StartingPopupView: View {
//    @Binding var popupToggle: Bool
    private let store: StoreOf<PopupReducer>
    @ObservedObject var viewStore: ViewStoreOf<PopupReducer>
    init(store: StoreOf<PopupReducer>) {
        self.store = store
        self.viewStore = ViewStore(self.store, observe: { $0 })
    }
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                Image("food")
                    .resizable()
            }
            
            Button {
                viewStore.send(.detailButtonTapped)
            } label: {
                Text("자세히 보기")
                    .font(.body)
                    .bold()
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity, maxHeight: 50)
            .background(.green)
            .cornerRadius(40)
            .padding(.horizontal, 10)
            .padding(.vertical, 10)
            HStack {
                
                Button {
                    viewStore.send(.neverShowButtonTapped)
                } label: {
                    Text("다시보지 않기")
                }
                
                Spacer()
                
                Button {
                    viewStore.send(.dismissButtonTapped)
                } label: {
                    HStack {
                        Image(systemName: "multiply")
                        Text("닫기")
                    }
                    .fontWeight(.light)
                }
            }
            .foregroundColor(.black)
            .padding([.leading, .trailing], 50)
        }
    }
}

struct StartingPopupView_Previews: PreviewProvider {
    static var previews: some View {
        StartingPopupView(
            store: StoreOf<PopupReducer>(
                initialState: .init(),
        reducer: {
            PopupReducer()._printChanges()
        }))
    }
}

