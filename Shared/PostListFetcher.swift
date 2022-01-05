//
//  PostListFetcher.swift
//  BlogStats
//
//  Created by Samuel Kraft on 2022-01-05.
//

import SwiftUI

@MainActor
class PostListFetcher: ObservableObject {
    @Published var postData = PostList(posts: [Post.defaultPost])
    @Published var loading = false
    
    init() {
        loading = true
    }

    let urlString = "https://samuelkraft.com/api/stats"
    
    enum FetchError: Error {
        case badRequest
        case badJSON
    }
    
    @available(iOS 15.0, *)
     func fetchData() async
     throws  {
        guard let url = URL(string: urlString) else { return }

        let (data, response) = try await URLSession.shared.data(for: URLRequest(url: url))
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw FetchError.badRequest }

        postData = try JSONDecoder().decode(PostList.self, from: data)
        self.loading = false
    }
    
}
