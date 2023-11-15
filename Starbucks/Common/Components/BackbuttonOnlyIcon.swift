//
//  BackbuttonOnlyIcon.swift
//  Starbucks
//
//  Created by mino on 2023/11/15.
//

import SwiftUI

struct BackbuttonOnlyIcon: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var backbuttonColor: Color?
    var body: some View {
        Button(
            action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.backward")
                .aspectRatio(contentMode: .fit)
                .foregroundColor(backbuttonColor ?? Color.black)
            }
    }
}

struct BackbuttonOnlyIcon_Previews: PreviewProvider {
    static var previews: some View {
        BackbuttonOnlyIcon()
    }
}
