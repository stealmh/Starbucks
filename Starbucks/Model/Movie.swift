//
//  Movie.swift
//  Starbucks
//
//  Created by mino on 2023/12/01.
//

import Foundation

struct Movie: Equatable, Codable {
    let results: [MovieDetail]
}

struct MovieDetail: Equatable, Codable, Identifiable {
    let id: Int?
    let adult: Bool?
}
