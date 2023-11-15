//
//  Playground.swift
//  Starbucks
//
//  Created by mino on 2023/10/25.
//

import SwiftUI


struct HomePlaygroundView: View {
    @StateObject var homeData = HomeViewModel()
    @Environment(\.colorScheme) var scheme
    @State var scrollDown: Bool = true
    @State var checkOffsetValue: CGFloat = 0.0
    @State var progressbarPercent: Double = 0
    @State var deleveryButtonToggle: Bool = false
    @State private var recommedCoffee: [RecommendCoffee] = [RecommendCoffee(title: "아이스 아메리카노", coffeeImage: "food"), RecommendCoffee(title: "아이스 뭐라카노", coffeeImage: "food"), RecommendCoffee(title: "아이스 디카페인 카페 아메리카노", coffeeImage: "food")]
    @State private var foodList: [String] = ["choclate", "cookie", "food", "fries", "pizza", "sandwich"]
    @State private var noticeList: [HomeNotice] = HomeNotice.mock
    
    
    @State var isHide = true
    var body: some View {
        NavigationStack {
            ZStack {
                    VStack {
                        VStack(alignment: .leading) {
                            Image("food")
                                .resizable()
                                .frame(height: 200)
                                .background(.red)
                            Text("15 ★ until Gold Level")
                                .foregroundColor(.green)
                            HStack {
                                ProgressView("", value: progressbarPercent, total: 100)
                                    .padding(.trailing, 5)
                                    .tint(.green)
                                    .animation(.easeInOut(duration: 2), value: progressbarPercent)
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
                            
                            .onAppear {
                                self.progressbarPercent = 60
                            }
                        }
//                        .ignoresSafeArea(edges: .top)
//                        .background(.white)

                        HomeHeader()
                        ScrollView {
                            LazyVStack(alignment: .center, spacing: 0, pinnedViews: [.sectionHeaders], content: {
                                GeometryReader { reader -> AnyView in
                                    let yAxis = reader.frame(in: .global).midY
                                    
                                    if yAxis < 0 && !isHide {
                                        DispatchQueue.main.async {
                                            self.isHide = true
                                        }
                                    }
                                    
                                    if yAxis > 0 && isHide {
                                        DispatchQueue.main.async {
                                            self.isHide = false
                                        }
                                    }
                                    
                                    return AnyView(Text("").frame(width:0, height: 0))
                                }
                                eventCard
                                noticeHeader
                                noticeCard
                                
                                configureDefaultHeader("고객님을 위한 추천 메뉴")
                                recommendCard
                                
                                configureDefaultHeader("하루가 달콤해지는 디저트")
                                recommendCard
                                
                                eventCard
                            })
                        }

                    }
                    .ignoresSafeArea(edges: .top)
                    .background(.white)
//                    .padding(.bottom, 140)
//                    .frame(height: 1450)
//                    .frame(minHeight: 100, maxHeight: 200)

                
                VStack {
                    Spacer()
                    HStack {
                        //
                        Button {
                            deleveryButtonToggle.toggle()
                        } label: {
                            ZStack {
                                Circle().fill(.white)
                                Text("배달버튼 체크")
                                    .lineLimit(2)
                            }.frame(width: 100, height: 100)
                        }
                        .hidden()
                        //
                        Spacer()
                        Capsule()
                            .fill(.green)
                            .frame(width: scrollDown ? 70 : 210, height: 70)
                            .animation(.easeIn, value: scrollDown)
                            .padding(.trailing, 10)
                    }
                }
                .animation(.easeOut, value: deleveryButtonToggle)
            }
        }
    }
}

extension HomePlaygroundView {
    private var eventCard: some View {
        VStack(alignment: .center, spacing: 10, content: {
            
            ForEach(foodList, id: \.self) { foodName in
                
                Image(foodName)
                    .resizable()
                    .frame(height: foodName == "sandwich" ? 300 : 180)
            }
            
        })
        .padding([.leading, .trailing], 10)
        .padding(.bottom, 40)
    }
    
    private var noticeHeader: some View {
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
    
    private var noticeCard: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(noticeList, id: \.self) { list in
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
    
    private var recommendCard: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(recommedCoffee, id: \.self) { list in
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
    
    private func configureDefaultHeader(_ title: String) -> some View {
        return HStack {
            Text(title)
                .font(.title2)
                .bold()
            Spacer()
        }.padding(.leading, 20)
    }
}

struct HomePlaygroundView_Previews: PreviewProvider {
    static var previews: some View {
        HomePlaygroundView()
            .ignoresSafeArea()
    }
}

