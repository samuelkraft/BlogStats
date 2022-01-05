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
    var image: String
    var summary: String
    
    static let defaultPost = Post(id: "x", title: "Hello this is a very long title that spans two lines", slug: "hello",  publishedAt: "2022-01-04", likes: 10, views: 300, image: "/blog/vanilla-extract-with-next-themes/image.png", summary: "Lorem ipsum…")
}
