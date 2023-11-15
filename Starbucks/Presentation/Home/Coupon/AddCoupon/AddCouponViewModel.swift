//
//  AddCouponViewModel.swift
//  Starbucks
//
//  Created by mino on 2023/10/25.
//

import Foundation

class AddCouponViewModel: ObservableObject {
    @Published var selectRadioButton: RadioButtonType = .recipe
    @Published var recipeText1 = ""
    @Published var recipeText2 = ""
    @Published var recipeText3 = ""
    @Published var recipeText4 = ""
    @Published var recipeCouponRegisterTextField = ""
    
    @Published var mmsText1 = ""
    @Published var mmsText2 = ""
    @Published var mmsText3 = ""
    @Published var mmsCouponPhoneNumberTextField = ""
    
    @Published var starText1 = ""
    @Published var starText2 = ""
    @Published var starText3 = ""
    @Published var starCouponPinNumberTextField = ""
}
