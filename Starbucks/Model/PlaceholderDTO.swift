//
//  PlaceholderDTO.swift
//  Starbucks
//
//  Created by DEV IOS on 2023/11/27.
//

import Foundation

//MARK: - Model
struct PlaceholderDTO: Identifiable, Equatable, Decodable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
