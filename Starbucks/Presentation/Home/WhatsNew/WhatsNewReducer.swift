//
//  WhatsNewReducer.swift
//  Starbucks
//
//  Created by DEV IOS on 2023/11/20.
//

import ComposableArchitecture
import CuteNetwork
import Foundation

struct WhatsNewReducer: Reducer {
    struct State: Equatable {
        var pageNumber: Int = 1
        let totalpage = 10
        var movieList: IdentifiedArrayOf<MovieDetail> = []
        var menuCase: MenuCase = .all
        var menuListButtonToggle: Bool = false
        var loading = false
    }
    enum Action: Equatable {
        case onAppear
        case movieListResponse(TaskResult<Movie>)
        case scrollIsEnd(MovieDetail)
        case fakeLoadingStarted
        case fakeLoadingEnd
        case menuButtonTapped
        case menuDetailButtonTapped(MenuCase)
    }

    @Dependency(\.networkManager) var networkManager
    
    private func core(into state: inout State, action: Action) -> EffectOf<Self> {
        switch action {
        case .onAppear:
            return .run { [state] send in
                let result = try await networkManager.getMovieList(state.pageNumber)
                await send(.movieListResponse(TaskResult(result)))
            }
            
        case .movieListResponse(.success(let movieList)):
            movieList.results
                .filter { $0.id != nil }
                .forEach { state.movieList.append($0) }
            return .none
            
        case .movieListResponse(.failure(let error)):
            switch error as! NetworkError {
            case .parsingError:
                print("파싱에러ㅠ")
            default:
                print("is default")
            }
            return .none
            
        case .scrollIsEnd(let movieDetail):
            guard let index = state.movieList.firstIndex(where: { $0.id == movieDetail.id }) else { return .none }
            if index == state.movieList.count - 1 && state.pageNumber != state.totalpage {
                state.pageNumber += 1
                return .run { send in
                    await send(.onAppear)
                }
            }
            return .none
        case .fakeLoadingStarted:
            state.loading = true
            return .run { send in
                try await Task.sleep(nanoseconds: 1 * 1_000_000_000)
                await send(.fakeLoadingEnd)
            }
            
        case .fakeLoadingEnd:
            state.loading = false
            return .none
        case .menuButtonTapped:
            state.menuListButtonToggle.toggle()
            return .none
        case .menuDetailButtonTapped(let menuCase):
            state.menuCase = menuCase
            state.menuListButtonToggle.toggle()
            return .none
        }
    }
    
    var body: some ReducerOf<Self> {
        Reduce(self.core)
            .onChange(of: \.menuCase) { oldValue, newValue in
                Reduce { _, _ in
                        .run { send in await send(.fakeLoadingStarted) }
                }
            }
            ._printChanges()
        
    }
}

