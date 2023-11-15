//
//  NoticeViewModel.swift
//  Starbucks
//
//  Created by mino on 2023/10/25.
//

import Foundation

protocol NoticeViewType {
    func itemTapGesture(_ id: UUID)
    func menuCaseDidChange(_ menuCase: NoticeCase)
    func deleteMessage()
    func writeReview()
}

final class NoticeViewModel: NoticeViewType, ObservableObject {
    @Published var menuCase: NoticeCase = .all
    @Published var isLoading: Bool = true
    @Published var menuListButtonToogle: Bool = false
    @Published var reviewPopupPresented: Bool = false
    @Published var noticeList: [NoticeModel] = NoticeModel.mock
    @Published var filterNotice: [NoticeModel] = []
    @Published var popupStyle: PopupStyle = .review
    
    init() {
        notiveViewOnAppear()
    }
    
    private func notiveViewOnAppear() {
        isLoading = true
        Task { @MainActor in
            sleep(2)
            filterNotice = []
            filterNotice = noticeList
            isLoading = false
        }
    }
    
    func itemTapGesture(_ id: UUID) {
        guard let idx = filterNotice.firstIndex(where: {$0.id == id}) else { return }
        if let _ = filterNotice[idx].detail {
            filterNotice[idx].detail!.isOpen = true
        } else {
            popupStyle = .review
            reviewPopupPresented.toggle()
        }
    }
    
    func menuCaseDidChange(_ menuCase: NoticeCase) {
        filterNotice = []
        Task {
            sleep(1)
            if menuCase == .all {
                filterNotice = noticeList
            } else {
                filterNotice = noticeList.filter { $0.myType == menuCase }
            }
            isLoading = false
        }
    }
    
    func deleteMessage() {
        print(#function)
        noticeList = []
        filterNotice = []
        reviewPopupPresented.toggle()
    }
    
    func writeReview() {
        debugPrint(#function)
        reviewPopupPresented.toggle()
    }
}
