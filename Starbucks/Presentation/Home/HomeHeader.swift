//
//  HomeHeader.swift
//  Starbucks
//
//  Created by mino on 2023/10/25.
//

import SwiftUI

struct HomeHeader: View {
    @EnvironmentObject var homeData: HomeViewModel
    @Environment(\.colorScheme) var scheme
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    HStack {
                        NavigationLink {
                            WhatsNewView()
                        } label: {
                            whatsNewLabel
                        }
                        .padding(.trailing, 20)
                        
                        NavigationLink {
                            CouponView()
                        } label: {
                            couponLabel
                        }

                        Spacer()
                        NavigationLink {
                            NoticeView()
                        } label: {
                            noticeLabel
                        }
                    }
                    .frame(height: 40)
                    .padding([.leading, .trailing], 20)
                    Divider()
                }
            }
            .background(.white)
        }

    }
}
//MARK: - Preview
struct TestHeader_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            Home()
        }
    }
}
//MARK: - Configure Layout
extension HomeHeader {
    var whatsNewLabel: some View {
        HStack {
            Image(systemName: "envelope")
                .resizable()
                .frame(width: 30, height: 20)
                .foregroundColor(.black).opacity(0.5)
            Text("What's New")
                .foregroundColor(.black)
                .font(.subheadline)
        }
    }
    var couponLabel: some View {
        HStack {
            Image(systemName: "creditcard")
                .resizable()
                .frame(width: 30, height: 20)
                .foregroundColor(.black).opacity(0.5)
            Text("Coupon")
                .foregroundColor(.black)
                .font(.subheadline)
        }
    }
    var noticeLabel: some View {
        Image(systemName: "bell")
            .resizable()
            .frame(width: 20, height: 20)
            .foregroundColor(.black).opacity(0.5)
    }
}
