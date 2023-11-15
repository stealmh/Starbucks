//
//  CouponInfoView.swift
//  Starbucks
//
//  Created by DEV IOS on 2023/11/15.
//

import SwiftUI
import Combine

enum InfoPaging: CaseIterable {
    case person
    case house
    case circle
    case square
    
    var color: Color {
        switch self {
        case .person: return .red
        case .house: return .orange
        case .circle: return .yellow
        case .square: return .green
        }
    }
}

struct CouponInfoView: View {
    private let title = "쿠폰 이용안내"
    var timer = Timer()
    @State private var count: Int = 3
    let futureData: Date = Calendar.current.date(byAdding: .hour, value: 1, to: Date()) ?? Date()
    @State private var currentPage: InfoPaging = .person
    @State var visible = CurrentValueSubject<Bool, Never>(false)
    @State var buttonHidden = false
    var body: some View {
        VStack {
            Text("(실제로는 자기네들 온보딩 들어감)")
            ZStack {
                TabView(selection: $currentPage) {
                    ForEach(InfoPaging.allCases, id: \.self) { trip in
                        Rectangle()
                            .foregroundColor(trip.color)
                            .frame(height: 450)
                            .clipShape(RoundedRectangle(cornerRadius: 25.0))
                            .padding(.horizontal, 20)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                HStack {
                    Button {
                        switch currentPage {
                        case .person: return
                        case .house:
                            currentPage = .person
                        case .circle:
                            currentPage = .house
                        case .square:
                            currentPage = .circle
                        }
                    } label: {
                        ZStack {
                            Circle()
                                .fill(.gray)
                                .frame(width: 50, height: 50)
                                .overlay {
                                    Image(systemName: "chevron.backward")
                                        .resizable()
                                        .frame(width: 10, height: 15)
                                        .foregroundColor(.white)
                                }
                        }
                    }
                    Spacer()
                    Button {
                        switch currentPage {
                        case .person:
                            currentPage = .house
                        case .house:
                            currentPage = .circle
                        case .circle:
                            currentPage = .square
                        case .square: return
                        }
                    } label: {
                        ZStack {
                            Circle()
                                .fill(.gray)
                                .frame(width: 50, height: 50)
                                .overlay {
                                    Image(systemName: "chevron.forward")
                                        .resizable()
                                        .frame(width: 10, height: 15)
                                        .foregroundColor(.white)
                                }
                        }
                    }
                }
                .opacity(buttonHidden ? 0 : 1)
                .padding([.leading, .trailing], 20)
            }
        }
        .navigationSetting(title)
        .onTapGesture {
            buttonHidden.toggle()
            visible.send(buttonHidden)
        }
        .onReceive(visible) { publish in
            Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
                buttonHidden = true
            }
        }
    }
}
//MARK: - Preview
struct CouponInfoView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CouponInfoView()
        }
    }
}
//MARK: - Configure NavigationBar
fileprivate extension View {
    func navigationSetting(_ title: String) -> some View {
        self
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(title)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: BackbuttonOnlyIcon())
            .toolbar(.hidden, for: .tabBar)
    }
}
