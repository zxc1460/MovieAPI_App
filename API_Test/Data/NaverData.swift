//
//  NaverJSON.swift
//  API_Test
//
//  Created by Seok on 2020/10/27.
//

import Foundation

struct MovieResponse: Codable {
    let lastBuildDate: String
    let total: Int
    let start: Int
    let display: Int
    let items: [Movie]
}

struct Movie: Codable {
    let title: String
    let link: String
    let image: String
    let subtitle: String
    let pubDate: String
    let director: String
    let actor: String
    let userRating: String
}
