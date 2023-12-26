//
//  CardSettingReducer.swift
//  Starbucks
//
//  Created by mino on 2023/12/07.
//

import ComposableArchitecture
import Foundation

struct CardSettingReducer: Reducer {
    
    struct State: Equatable {
        @PresentationState var destination: Destination.State?
        var cardList: IdentifiedArrayOf<Card>
        var isLoading = false
    }
    
    enum Action: Equatable {
        case destination(PresentationAction<Destination.Action>)
        case addToolbarButtonTapped
        case popup
        case alert(Card)
        case cardSortComplted(IdentifiedArrayOf<Card>)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .popup:
                return .none
            case .alert(let item):
                state.destination = .alert(CardChangeReducer.State(selectCard: item,
                                                                   title: cardTitleParsing(item)))
                return .none
            case .addToolbarButtonTapped:
                state.destination = .addCard(AddCardReducer.State())
                return .none
            case .destination(.presented(.alert(.okButtonTapped(let item)))):
                let newCardList = mainCardChange(state.cardList, item)
                state.cardList = newCardList
                state.destination = nil
                return .run { send in
                    await send(.cardSortComplted(newCardList))
                }
            case .destination(.presented(.alert(.cancelButtonTapped))):
                state.destination = nil
                return .none
            case .cardSortComplted(let cardList):
                state.destination = nil
                return .none
            case .destination:
                return .none
            }
        }
        .ifLet(\.$destination, action: /Action.destination) {
            Destination()
        }
    }
}
//MARK: - Navigation
extension CardSettingReducer {
    struct Destination: Reducer {
        enum State: Equatable {
            case alert(CardChangeReducer.State)
            case addCard(AddCardReducer.State)
        }
        
        enum Action: Equatable {
            case alert(CardChangeReducer.Action)
            case addCard(AddCardReducer.Action)
        }
        
        var body: some ReducerOf<Destination> {
            Scope(state: /State.alert , action: /Action.alert) {
                CardChangeReducer()
            }
            Scope(state: /State.addCard , action: /Action.addCard) {
                AddCardReducer()
            }
        }
    }
}
//MARK: - Help func
fileprivate extension CardSettingReducer {
    /// 카드의 제목을 받아올 때 인식번호를 제거한 제목 값을 리턴받습니다.
    func cardTitleParsing(_ item: Card) -> String {
        let originalName = item.cardName
        let parsing = originalName.replacingOccurrences(of: "\\(\\d+\\)", with: "", options: .regularExpression)
        return parsing
    }
    
    func mainCardChange(_ cardList: IdentifiedArrayOf<Card>, _ item: Card) -> IdentifiedArrayOf<Card> {
        var myCard = cardList
        let convertMyCard = myCard.map { card in
            var mutableCard = card
            mutableCard.isHighlight = false
            return mutableCard
        }
        myCard = IdentifiedArrayOf(uniqueElements: convertMyCard)
        myCard.remove(id: item.id)
        let newItem = Card(cardName: item.cardName,
                           cardNumber: item.cardNumber,
                           cardImage: item.cardImage,
                           money: item.money,
                           isHighlight: true)
        myCard.insert(newItem, at: 0)
        return myCard
    }
}
