//
//  AddCouponReducer.swift
//  Starbucks
//
//  Created by DEV IOS on 2023/11/22.
//

import ComposableArchitecture
import Foundation

struct AddCouponReducer: Reducer {
    struct Destination: Reducer {
        enum State: Equatable {
            case scanner(ScannerReducer.State = ScannerReducer.State())
        }
        enum Action: Equatable {
            case scanner(ScannerReducer.Action)
        }
        
        var body: some ReducerOf<Self> {
            Scope(state: /State.scanner, action: /Action.scanner) {
                ScannerReducer()
            }
        }
    }
    
    struct State: Equatable {
        @PresentationState var destination: Destination.State?
        var selectRadioButton: RadioButtonType = .recipe
        
        @BindingState var recipeText1 = ""
        @BindingState var recipeText2 = ""
        @BindingState var recipeText3 = ""
        @BindingState var recipeText4 = ""
        @BindingState var recipeCouponRegisterTextField = ""
        
        @BindingState var mmsText1 = ""
        @BindingState var mmsText2 = ""
        @BindingState var mmsText3 = ""
        @BindingState var mmsCouponPhoneNumberTextField = ""
        
        @BindingState var starText1 = ""
        @BindingState var starText2 = ""
        @BindingState var starText3 = ""
        @BindingState var starCouponPinNumberTextField = ""
        
        enum Field: String, Hashable {
            case recipe1, recipe2, recipe3, recipe4
            case mms1, mms2, mms3
            case star1, star2, star3
        }
    }
    
    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case radioButtonTapped(RadioButtonType)
        case destination(PresentationAction<Destination.Action>)
        case scannerButtonTapped
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .radioButtonTapped(let type):
                state.selectRadioButton = type
                return .none
            case .binding:
                return .none
            case .scannerButtonTapped:
                state.destination = .scanner()
                return .none
            case .destination(.presented(.scanner(.getBarcodeResult(let barcode)))):
                state.recipeCouponRegisterTextField = barcode
                return .run { send in
                    await send(.destination(.dismiss))
                }
            case .destination:
                return .none
            }
        }
        .ifLet(\.$destination, action: /Action.destination) {
            Destination()
        }
    }
}
