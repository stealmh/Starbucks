//
//  OrderView.swift
//  Starbucks
//
//  Created by DEV IOS on 2023/11/16.
//

import SwiftUI
import SwiftUIIntrospect

struct OrderView: View {
    
    var body: some View {
        NavigationStack {
            orderViewTopTabBar()
        }
        .navigationTitle("Order")
        .toolbarBackground(.white, for: .navigationBar)
        .toolbar {
            Image(systemName: "magnifyingglass")
        }
    }
}
//MARK: - Preview
struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            OrderView()
        }
    }
}
//MARK: - Configure Layout
extension OrderView {
    func orderViewTopTabBar() -> some View {
        ScrollView {
            LazyVStack(alignment: .leading, pinnedViews: .sectionHeaders) {
                Section(header: OrderHeaderView()) {
                    ForEach(Order.mock) { data in
                        HStack{
                            Circle()
                                .fill(.green)
                                .frame(width: 70, height: 70)
                                .overlay {
                                    Image(systemName: data.image)
                                }
                            VStack {
                                Text(data.title)
                                if let text = data.subTitle {
                                    Text(text)
                                }
                            }
                        }
                        .padding([.leading, .trailing, .top], 20)
                    }
                }
            }
        }
    }
}
