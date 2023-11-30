//
//  NewNetworkHelper.swift
//  Starbucks
//
//  Created by DEV IOS on 2023/11/27.
//

import CuteNetwork
import Foundation

enum EndPoint: EndPointType {
    case getSinglePost(Int)
    case getPosts
    case movieList(Int)
    
    var baseURL: URL {
        switch self {
        case .getPosts, .getSinglePost:
            return URL(string:"https://jsonplaceholder.typicode.com")!
        case .movieList:
            return URL(string:"https://api.themoviedb.org")!
        }
    }
    
    var path: String {
        switch self {
        case .getPosts:
            return "/posts"
        case .getSinglePost(let userId):
            return "/posts/\(userId)"
        case .movieList:
            return "/3/movie/changes"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
        
    }
    
    var task: HTTPTask {
        switch self {
        case .getPosts, .getSinglePost:
            return .request
        case .movieList(let pageNumber):
            return .requestParametersAndHeaders(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: ["page": "\(pageNumber)"], additionHeaders: [
                "accept": "application/json",
                "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzNjkzMTAwNjMzMzE4YjQ0ZWNjN2E1YWMyNWYzY2NhZSIsInN1YiI6IjY1MWU3NTg4NzQ1MDdkMDBlMjEwYTFiMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.sxby7vWnOQoFbTqkGWNUleg5M_nWo8EKspGBaeNoBCg"])
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .getPosts, .getSinglePost:
            return ["ContentType": "application/json"]
        case .movieList:
            return nil
        }
    }
    
//    var headers: [String: String]? {
//        switch self {
//        case .getPosts, .getSinglePost:
//            return ["Content-Type": "application/json"]
//        case .movieList:
//            return [
//                "accept": "application/json",
//                "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzNjkzMTAwNjMzMzE4YjQ0ZWNjN2E1YWMyNWYzY2NhZSIsInN1YiI6IjY1MWU3NTg4NzQ1MDdkMDBlMjEwYTFiMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.sxby7vWnOQoFbTqkGWNUleg5M_nWo8EKspGBaeNoBCg"
//              ]
//        }
//    }
}
