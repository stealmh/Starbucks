//
//  NoticePopupStyle.swift
//  Starbucks
//
//  Created by mino on 2023/10/25.
//

import Foundation

enum PopupStyle {
    case review
    case deleteMessage
    
    /// 팝업 뷰의 제목입니다.
    var title: String {
        switch self {
        case .review: return "마이 스타벅스 리뷰\n"
        case .deleteMessage: return "알림함의 모든 메시지를 삭제하시겠어요?"
        }
    }
    /// 팝업 뷰의 내용 칸 입니다.
    var content: String {
        switch self {
        case .review:
            return "사이렌 오더를 이용해 주셔서 감사합니다.\n지금 마이 스타벅스 리뷰에 참여하시면\n별★을 선물로 드려요!\n마이 스타벅스 리뷰에 참여하시겠어요?\n\n10월 21일 까지\n메뉴 -> '마이 스타벅스 리뷰'를 통해\n참여하실 수 있습니다."
        case .deleteMessage:
            return ""
        }
    }
    /// 왼쪽 버튼의 이름입니다.
    var firstButtonTitle: String {
        switch self {
        case .review: return "나중에 하기"
        case .deleteMessage: return "아니오"
        }
    }
    /// 오른쪽 버튼의 이름입니다.
    var secondButtonTitle: String {
        switch self {
        case .review: return "지금 참여하기"
        case .deleteMessage: return "전체 삭제"
        }
    }
    /// 팝업 뷰의 높이입니다.
    var viewHeight: CGFloat {
        switch self {
        case .review: return 400
        case .deleteMessage: return 150
        }
    }
}
