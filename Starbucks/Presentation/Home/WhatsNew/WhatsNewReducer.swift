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
        var postList: IdentifiedArrayOf<PlaceholderDTO> = []
        var movieList: IdentifiedArrayOf<MovieDetail> = []
    }
    enum Action: Equatable {
        case onAppear
        case response(TaskResult<[PlaceholderDTO]>)
        case movieListResponse(TaskResult<Movie>)
    }
    
    @Dependency(\.networkManager) var networkManager
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .run { [state] send in
//                    let result = try await networkManager.getPosts()
                    let result2 = try await networkManager.getMovieList(state.pageNumber)
//                    await send(.response(TaskResult(result)))
                    await send(.movieListResponse(TaskResult(result2)))
                }
            case .response(.success(let posts)):
                print("post is \(posts)")
                return .none
            case .movieListResponse(.success(let movieList)):
//                state.movieList = movieList.results
                let a = movieList.results
                print(movieList)
                return .none
            case .movieListResponse(.failure(let error)):
                print("error: \(error)")
                return .none
            case .response(.failure(let error)):
                switch error as! NetworkError {
                default:
                    print("error")
                }
                return .none
            }
        }._printChanges()
    }
}

