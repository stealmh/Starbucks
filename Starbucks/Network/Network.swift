//
//  Network.swift
//  Starbucks
//
//  Created by DEV IOS on 2023/11/24.
//

import CuteNetwork
import Dependencies
import Foundation

//MARK: NetworkClient
struct NetworkClient {
    var getSinglePost: () async throws -> Result<PlaceholderDTO, NetworkError>
    var getPosts: () async throws -> Result<[PlaceholderDTO], NetworkError>
    var getMovieList: (_ pageNumber: Int) async throws -> Result<Movie, NetworkError>
}
//MARK: - DependencyKey
extension NetworkClient: DependencyKey {
    static var liveValue = Self(
        getSinglePost: {
            do {
                let cute = Cute<EndPoint>()
                let response: PlaceholderDTO = try await cute.petit(.getSinglePost(3), petitLogVisible: false)
                return .success(response)
            } catch {
                return .failure(error as! NetworkError)
            }
        }, getPosts: {
            do {
                let cute = Cute<EndPoint>()
                let response: [PlaceholderDTO] = try await cute.petit(.getPosts, petitLogVisible: false)
                return .success(response)
            } catch {
                return .failure(error as! NetworkError)
            }
        }, getMovieList: { pageNumber in
            do {
                let cute = Cute<EndPoint>()
                let response: Movie = try await cute.petit(.movieList(pageNumber), petitLogVisible: false)
                return .success(response)
            } catch {
                return .failure(error as! NetworkError)
            }
        }
    )
    
//    static var previewValue = Self (
//        getSinglePost: {
//            let mock: PlaceholderDTO = PlaceholderDTO(
//                userId: 123,
//                id: 123,
//                title: "this is title (mock)",
//                body: "hello this is body (mock)")
//            return .success(mock)
//        },
//        
//        getPosts: {
//            let mock: [PlaceholderDTO] = [
//                PlaceholderDTO(
//                userId: 123,
//                id: 123,
//                title: "this is title (mock)",
//                body: "hello this is body (mock)")
//            ]
//            return .success(mock)
//        }, getMovieList: {
//            let mock: [Movie] = []
//            return .success(mock)
//        }
//    )
}
//MARK: - DependencyValues
extension DependencyValues {
    var networkManager: NetworkClient {
        get { self[NetworkClient.self] }
        set { self[NetworkClient.self] = newValue }
    }
}
