//
//  TotalsView.swift
//  BlogStats
//
//  Created by Samuel Kraft on 2022-01-05.
//

import SwiftUI

struct TotalsView: View {
    @ObservedObject var networkManager = NetworkManager()
    private var twoColumnGrid = Array(repeating: GridItem(.flexible(), spacing: 14), count: 2)
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)).ignoresSafeArea()
                VStack {
                    if networkManager.loading {
                        ProgressView()
                    } else {
                        ScrollView {
                            LazyVGrid(columns: twoColumnGrid, spacing: 14) {
                                TotalsItemView(type: "Likes", number: networkManager.posts.posts.map({$0.likes}).reduce(0, +))
                                TotalsItemView(type: "Views", number: networkManager.posts.posts.map({$0.views}).reduce(0, +))
                                TotalsItemView(type: "Posts", number: networkManager.posts.posts.count)
                            }
                        }
                    }
                }.padding(.horizontal)
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
        }.frame(maxWidth: .infinity, alignment: .leading).padding(14).background(.background).cornerRadius(14)
    }
}

struct TotalsView_Previews: PreviewProvider {
    static var previews: some View {
        TotalsView()
    }
}
