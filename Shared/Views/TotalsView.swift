//
//  TotalsView.swift
//  BlogStats
//
//  Created by Samuel Kraft on 2022-01-05.
//

import SwiftUI

struct TotalsView: View {
    @EnvironmentObject var fetcher: PostListFetcher
    private var twoColumnGrid = Array(repeating: GridItem(.flexible(), spacing: 14), count: 2)
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemGroupedBackground).ignoresSafeArea()
                VStack {
                    if fetcher.loading {
                        ProgressView()
                    } else {
                        ScrollView {
                            LazyVGrid(columns: twoColumnGrid, spacing: 14) {
                                TotalsItemView(type: "Likes", number: fetcher.postData.posts.map({$0.likes}).reduce(0, +))
                                TotalsItemView(type: "Views", number: fetcher.postData.posts.map({$0.views}).reduce(0, +))
                                TotalsItemView(type: "Posts", number: fetcher.postData.posts.count)
                            }
                        }
                    }
                }.padding(.horizontal)
            }.task {
                try? await fetcher.fetchData()
            }.navigationTitle(Text("Totals"))
        }
    }
}

struct TotalsItemView: View {
    var type: String
    var number: Int
    var body: some View {
        VStack(alignment: .leading) {
            Text(String(number)).font(.title).fontWeight(.semibold)
            Text(type).font(.subheadline).foregroundColor(.secondary)
        }.frame(maxWidth: .infinity, alignment: .leading).padding(14).background(Color(.secondarySystemGroupedBackground)).cornerRadius(14)
    }
}

struct TotalsView_Previews: PreviewProvider {
    static var previews: some View {
        TotalsView()
    }
}
