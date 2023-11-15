//
//  WhatsNewCell.swift
//  Starbucks
//
//  Created by mino on 2023/10/25.
//

import SwiftUI

struct WhatsNewCell: View {
    var title: String
    var body: some View {
        HStack {
            Image("food")
                .resizable()
                .frame(width: 120, height: 70)
                .cornerRadius(5)
                .padding(.trailing, 5)
            
            VStack(alignment: .leading) {
                Text(title)
                    .lineLimit(2)
                    .padding(.trailing, 5)
                Text("2023.10.17")
            }
            Spacer()
        }
        .padding(.leading, 20)
    }
}

struct WhatsNewCell_Previews: PreviewProvider {
    static var previews: some View {
        WhatsNewCell(title: "탄소중립포인트제 본인인증 고객대상 인센티브 지급일정 안내")
    }
}
