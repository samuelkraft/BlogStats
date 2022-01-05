//
//  TotalsView.swift
//  BlogStats
//
//  Created by Samuel Kraft on 2022-01-05.
//

import SwiftUI

struct TotalsView: View {
    @ObservedObject var networkManager = NetworkManager()
    var body: some View {
        VStack {
            if networkManager.loading {
                Text("Loading ...")
            } else {
                VStack {
                    Text("\(networkManager.posts.posts.map({$0.likes}).reduce(0, +)) likes")
                    Text("\(networkManager.posts.posts.map({$0.views}).reduce(0, +)) views")
                }
            }
        }.navigationTitle(Text("Totals"))
    }
}

struct TotalsView_Previews: PreviewProvider {
    static var previews: some View {
        TotalsView()
    }
}
