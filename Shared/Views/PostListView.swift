//
//  ContentView.swift
//  Shared
//
//  Created by Samuel Kraft on 2022-01-03.
//

import Foundation
import SwiftUI

struct PostListView: View {
    @State private var searchText = ""
    @State private var sort: Int = 0
    @ObservedObject var networkManager = NetworkManager()
    
    var body: some View {
        NavigationView {
            VStack {
                if networkManager.loading {
                    Text("Loading ...")
                } else {
                    List(networkManager.posts.posts.sorted(by: {
                        if (sort == 1) {
                            return $0.likes > $1.likes
                        } else if (sort == 2){
                            return $0.views > $1.views
                        } else {
                            return false
                        }
                        
                    })) { post in
                        NavigationLink(destination: PostDetailView(post: post)){
                            PostRow(post: post)
                        }
                    }.searchable(text: $searchText)
                }
            }.navigationTitle(Text("Blog Posts")).toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Menu {
                        Picker(selection: $sort, label: Text("Sorting options")) {
                            Label("Publish date", systemImage: "clock.fill").tag(0)
                            Label("Likes", systemImage: "heart.fill").tag(1)
                            Label("Views", systemImage: "eye.fill").tag(2)
                        }
                    }
                    label: {
                        Label("Sort", systemImage: "arrow.up.arrow.down")
                    }
                }
            }
        }
    }
}

struct PostListView_Previews: PreviewProvider {
    static var previews: some View {
        PostListView()
    }
}

struct PostRow: View {
    var post: Post
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(post.title).font(.headline).lineLimit(1)
            HStack(spacing: 6) {
                Text("\(post.views) views").font(.subheadline).foregroundColor(.secondary).lineLimit(1)
                Text("·").foregroundColor(.secondary)
                Text("\(post.likes) likes").font(.subheadline).foregroundColor(.secondary).lineLimit(1)
            }
        }
    }
}
