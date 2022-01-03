//
//  NetworkManager.swift
//  BlogStats
//
//  Created by Samuel Kraft on 2022-01-03.
//

import Foundation
import Combine

class NetworkManager: ObservableObject {
    @Published var posts = PostList(posts: [])
    @Published var loading = false
    private let api_url_base = "https://samuelkraft.com/api/stats"
    init() {
        loading = true
        loadData()
    }
    
    private func loadData() {
        guard let url = URL(string: "\(api_url_base)") else { return }
        URLSession.shared.dataTask(with: url){ (data, _, _) in
            guard let data = data else { return }
            let posts = try! JSONDecoder().decode(PostList.self, from: data)
            DispatchQueue.main.async {
                self.posts = posts
                self.loading = false
            }
        }.resume()
    }
}
