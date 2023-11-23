//
//  CouponInfoViewModel.swift
//  Starbucks
//
//  Created by mino on 2023/11/16.
//

import Foundation
import Combine

protocol CouponInfoViewAction {
    func preNextButtonTapped(type: PreNextButtonType)
    func viewDidTapped()
}

class CouponInfoViewModel: ObservableObject {
    /// Properties
    @Published var currentPage: InfoPaging = .person
    @Published var visible = CurrentValueSubject<Bool, Never>(false)
    @Published var buttonHidden = false
    var timer = Timer()
    var cancellable = Set<AnyCancellable>()
    
    init() {
        print("CouponInfoViewModel init")
        buttonVisibleDetect()
    }
    
    deinit {
        print("CouponInfoViewModel deinit")
        cancellable = Set<AnyCancellable>()
        timer.invalidate()
    }
}
//MARK: - CouponInfoView Logic
extension CouponInfoViewModel: CouponInfoViewAction {
    /// visible을 sink해 변화 감지 시 3초 후 버튼 hidden처리하는 '내부 로직'
    private func buttonVisibleDetect() {
        visible.sink { _ in
            Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
                self.buttonHidden = true
            }
        }
        .store(in: &cancellable)
    }
    /// 뷰가 탭됐을 때 액션
    func viewDidTapped() {
        buttonHidden.toggle()
        visible.send(buttonHidden)
    }
    /// 다음 / 이전 버튼을 눌렀을 때 액션
    func preNextButtonTapped(type: PreNextButtonType) {
        switch (type, currentPage) {
        case (.previous, .person): return
        case (.next, .square): return
        case (.previous, .house): currentPage = .person
        case (.previous, .circle): currentPage = .house
        case (.previous, .square): currentPage = .circle
        case (.next, .person): currentPage = .house
        case (.next, .house): currentPage = .circle
        case (.next, .circle): currentPage = .square
        }
    }
}
