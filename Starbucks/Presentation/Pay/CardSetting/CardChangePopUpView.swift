//
//  CardChangePopUpView.swift
//  Starbucks
//
//  Created by DEV IOS on 2023/12/07.
//

import ComposableArchitecture
import SwiftUI

struct CardChangePopUpView: View {
    let store: StoreOf<CardChangeReducer>
    @ObservedObject var viewStore: ViewStoreOf<CardChangeReducer>
    
    init(store: StoreOf<CardChangeReducer>) {
        self.store = store
        self.viewStore = ViewStore(self.store, observe: { $0 })
    }
    
}
//MARK: - View
extension CardChangePopUpView {
    var body: some View {
        ///Todo: Rectangle위에 그려야 하얀색으로 뜸
        ZStack {
            Rectangle()
                .frame(width: 100, height: 100)
                .foregroundColor(.white)
            VStack {
                VStack {
                    Text("this is title")
                    Text("this is contents")
                    
                    Divider()
                    HStack {
                        Text("no")
                        Divider()
                        Text("yes")
                            .foregroundColor(Palette.stackBucksGreen)
                    }
                }
            }
        }
        .frame(height: 100)
    }
}
//MARK: - Preview
struct CardChangePopUpView_Previews: PreviewProvider {
    static var previews: some View {
        CardChangePopUpView(store: Store(initialState: .init(), reducer: { CardChangeReducer() } ))
    }
}
