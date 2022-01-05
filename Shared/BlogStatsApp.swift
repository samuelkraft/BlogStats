//
//  BlogStatsApp.swift
//  Shared
//
//  Created by Samuel Kraft on 2022-01-03.
//

import SwiftUI

@main
struct BlogStatsApp: App {
    @StateObject private var fetcher = PostListFetcher()
    var body: some Scene {
        WindowGroup {
            MainView().environmentObject(fetcher)
        }
    }
}



struct MainView: View {
    var body: some View {
        TabView {
            PostListView()
                .tabItem {
                    Label("Posts", systemImage: "list.dash")
                }

            TotalsView()
                .tabItem {
                    Label("Totals", systemImage: "star.fill")
                }
        }
    }
}
