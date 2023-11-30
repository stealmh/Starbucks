//
//  WhatsNewViewModel.swift
//  Starbucks
//
//  Created by mino on 2023/10/25.
//

import Foundation

class WhatsNewViewModel: ObservableObject {
    @Published var pageNumber = 1
    @Published var movieList: [MovieDetail] = []
    let totalpage = 3
    private let headers = [
      "accept": "application/json",
      "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzNjkzMTAwNjMzMzE4YjQ0ZWNjN2E1YWMyNWYzY2NhZSIsInN1YiI6IjY1MWU3NTg4NzQ1MDdkMDBlMjEwYTFiMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.sxby7vWnOQoFbTqkGWNUleg5M_nWo8EKspGBaeNoBCg"
    ]
    
    func request<T: Codable>(session: URLSession = .shared, type: T.Type) async throws -> T {
        print("\(#function) pageNumber: \(pageNumber), movieCount: \(movieList.count)")
        let url: URL = URL(string: "https://api.themoviedb.org/3/movie/changes?page=\(pageNumber)")!
        let request = buildRequest(from: url)
        
        let (data, response) = try await session.data(for: request)
        
        guard let response = response as? HTTPURLResponse,
              (200...300) ~= response.statusCode else {
            let statusCode = (response as! HTTPURLResponse).statusCode
            throw NetworkingError.a
        }
        
        let decoder = JSONDecoder()
        let res = try decoder.decode(T.self, from: data)
        return res
    }
    
    private func buildRequest(from url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        return request
    }
    
    func infiniteScroll(movieItem: MovieDetail) {
        guard let index = movieList.firstIndex(where: { $0.id == movieItem.id }) else { return }
        if index % 100 == 0  && pageNumber != totalpage {
            pageNumber += 1
            Task { @MainActor in
                let a = try await request(type: Movie.self)
                _ = a.results
                        .filter { $0.id != nil }
                        .map { movieList.append($0) }
            }
        }
    }
    
}

enum NetworkingError: Error {
    case a
}

struct Movie: Identifiable ,Equatable, Codable {
    var id = UUID()
    
    let results: [MovieDetail]
//    let total_pages: Int
}

struct MovieDetail: Equatable, Codable, Identifiable {
    let id: Int?
    let adult: Bool?
//    let a = UUID()
}
