//
//  Post.swift
//  BlogStats
//
//  Created by Samuel Kraft on 2022-01-03.
//

import Foundation

struct Post: Codable, Identifiable {
    var id: String
    var title: String
    var slug: String
    var publishedAt: String
    var likes: Int
    var views: Int
}
