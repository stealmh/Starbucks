//
//  MenuListCard.swift
//  Starbucks
//
//  Created by mino on 2023/11/15.
//

import SwiftUI

struct MenuListCard: View {
    @Binding var itemCase: SqaureBoxLayer
    @Binding var menuListButtonToggle: Bool
    
    var body: some View {
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
}

struct MenuListCard_Previews: PreviewProvider {
    static var previews: some View {
        MenuListCard(itemCase: .constant(MenuListPreviewCase.first), menuListButtonToggle: .constant(false))
    }
}

enum MenuListPreviewCase: SqaureBoxLayer {
    case first
    
    var title: String {
        switch self {
        case .first: return "frist"
        }
    }
}

