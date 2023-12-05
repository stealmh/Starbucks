//
//  NoticeReducer.swift
//  Starbucks
//
//  Created by mino on 2023/11/20.
//

import ComposableArchitecture
import Foundation

struct NoticeReducer: Reducer {
    /// For Navigation
    struct Destination: Reducer {
        enum State: Equatable {
            case popover(NoticePopupReducer.State)
        }
        
        enum Action: Equatable {
            case popover(NoticePopupReducer.Action)
        }
        
        var body: some ReducerOf<Destination> {
            Scope(state: /State.popover, action: /Action.popover) {
                NoticePopupReducer()
            }
        }
    }
    /// NoticeReducer State
    struct State: Equatable {
        @PresentationState var destination: Destination.State?
        var menuCase: NoticeCase = .all
        var isLoading: Bool = true
        var menuListButtonToggle: Bool = false
        var noticeList: [NoticeModel] = NoticeModel.mock
        var filterNotice: [NoticeModel] = []
        var popupStyle: PopupStyle = .review
        
    }
    /// NoticeReducer Action
    enum Action: Equatable {
        /// View onAppear
        case onAppear
        /// View onAppear Response
        case onAppearResponse
        /// 상단바 메뉴를 눌렀을 때
        case menuTapped
        /// 상단바 메뉴의 리스트를 눌렀을 때
        case menuListTapped(_ menu: NoticeCase)
        /// 아이템 항목 터치
        case itemTapGesture(_ id: UUID)
        /// 상단바 메뉴리스트를 눌렀을 때 해당되는 메뉴값을 감지
        case menuCaseDidChanged(_ menuCase: NoticeCase)
        /// 감지된 메뉴값을 통해 값 업데이트
        case menuCaseDidChangedResponse(_ menuCase: NoticeCase)
        /// 항목들 삭제명령 수행
        case deleteMessageButtonTapped
        /// 리뷰작성하러가기 (웹뷰로 실제 연결 X)
        case writeReviewButtonTapped
        /// 툴바의 삭제아이콘 클릭시
        case deleteToolbarTapped
        /// For Destination
        case destination(PresentationAction<Destination.Action>)
    }
    /// NoticeReducer  Action(Core)
    private func core(state: inout State, action: Action) -> EffectOf<Self> {
        switch action {
        /// View onAppear
        case .onAppear:
            state.isLoading = true
            return .run { send in
                sleep(2)
                await send(.onAppearResponse)
            }
        /// View onAppear 결과처리
        case .onAppearResponse:
            state.filterNotice = []
            state.filterNotice = state.noticeList
            state.isLoading = false
            return .none
        /// 내부 항목들을 눌렀을 때
        case .itemTapGesture(let id):
            guard let idx = state.filterNotice.firstIndex(where: { $0.id == id }) else { return .none }
            if let _ = state.filterNotice[idx].detail {
                state.filterNotice[idx].detail!.isOpen = true
            } else {
                state.destination = .popover(NoticePopupReducer.State(style: .review))
            }
            return .none
        /// 메뉴 케이스가 바뀌었을 때 response로 전달
        case .menuCaseDidChanged(let menuCase):
            state.filterNotice = []
            return .run { send in
                sleep(1)
                await send(.menuCaseDidChangedResponse(menuCase))
            }
        /// 전달받은 메뉴케이스를 통해 정보 필터링
        case .menuCaseDidChangedResponse(let menuCase):
            if menuCase == .all {
                state.filterNotice = state.noticeList
            } else {
                state.filterNotice = state.noticeList.filter { $0.myType == menuCase }
            }
            state.isLoading = false
            return .none
        /// 실제 삭제 명령 수행
        case .deleteMessageButtonTapped:
            state.noticeList = []
            state.filterNotice = []
            /// [1]번 방식
            return .run { send in
                await send(.destination(.presented(.popover(.dismiss))))
            }
            /// [2]번 방식
//          return .run { send in
//              await send(.destination(.dismiss))
//          }
            /// [3]번 방식
//          state.destination = nil
//          return .none
        /// 작성버튼 클릭
        case .writeReviewButtonTapped:
            state.destination = nil
            return .none
        /// 메뉴버튼을 눌렀을 때 -> 카테고리 확장 토글
        case .menuTapped:
            state.menuListButtonToggle.toggle()
            return .none
        /// 카테고리 항목을 눌렀을 때
        case .menuListTapped(let menu):
            state.isLoading = true
            state.menuCase = menu
            state.menuListButtonToggle.toggle()
            return .none
        /// 툴바 삭제버튼을 눌렀을 때
        case .deleteToolbarTapped:
            state.destination = .popover(NoticePopupReducer.State(style: .deleteMessage))
            return .none
        /// Destination 관련
        /// 뷰 끌때
        case .destination(.presented(.popover(.dismiss))):
            state.destination = nil
            return .none
        /// 전체삭제버튼 클릭
        case .destination(.presented(.popover(.deleteMessage))):
            return .run { send in
                await send(.deleteMessageButtonTapped)
            }
        /// 리뷰작성하러가기 - 웹뷰 띄우면서 dismiss방식 (웹뷰 연결 안 할 예정)
        case .destination(.presented(.popover(.writeReview))):
            return .run { send in
                await send(.writeReviewButtonTapped)
            }
        /// 맨 아래에 배치 -> 순서바뀌면 위 열거형으로 처리된 액션들 트리거 X
        case .destination:
            return .none
        }
    }
    /// NoticeReducer  Action(Chaining)
    var body: some ReducerOf<Self> {
        Reduce(self.core)
        .onChange(of: \.menuCase, { oldValue, newValue in
            Reduce { _, _ in
                    .run { send in await send(.menuCaseDidChanged(newValue)) }
            }
        })
        .ifLet(\.$destination, action: /Action.destination) {
            Destination()
        }
    }
}
