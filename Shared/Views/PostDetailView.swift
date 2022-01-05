//
//  PostDetail.swift
//  BlogStats
//
//  Created by Samuel Kraft on 2022-01-04.
//

import SwiftUI

let BASE_URL = "https://samuelkraft.com"

struct PostDetailView: View {
    @State private var showSafari: Bool = false
    var post: Post
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            AsyncImage(url: URL(string: "\(BASE_URL)\(post.image)")) { phase in
                switch phase {
                    case .empty:
                    HStack(alignment: .center) {
                        ProgressView().frame(width: 375, height: 188)
                        }
                    case .success(let image):
                        image.resizable()
                             .aspectRatio(contentMode: .fit)
                             
                    case .failure:
                        Image(systemName: "photo")
                    @unknown default:
                        // Since the AsyncImagePhase enum isn't frozen,
                        // we need to add this currently unused fallback
                        // to handle any new cases that might be added
                        // in the future:
                        EmptyView()
                }
            }
            VStack(alignment: .leading, spacing: 22) {
                VStack(alignment: .leading, spacing: 4) {                Text(post.title).font(.title.leading(.tight)).fontWeight(.semibold)
                
                    HStack(spacing: 6) {
                        Text("\(post.views) views").font(.title3).foregroundColor(.secondary).lineLimit(1)
                        Text("·").foregroundColor(.secondary).font(.title3)
                        Text("\(post.likes) likes").font(.title3).foregroundColor(.secondary).lineLimit(1)
                    }
                }
                Button("Open Post"){
                    showSafari.toggle()
                }.buttonStyle(BaseButtonStyle())
                Text(post.summary).font(.body)
                 
                    
                    
            }.padding(.horizontal)
            
        }.navigationBarTitle(Text(post.title), displayMode: .inline).fullScreenCover(isPresented: $showSafari, content: {
            SFSafariViewWrapper(url: URL(string: "\(BASE_URL)/blog/\(post.slug)/")!)
    })
        Spacer()
    }
}


struct PostDetail_Previews: PreviewProvider {
    static var previews: some View {
        PostDetailView(post: Post.defaultPost)
    }
}

struct BaseButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    HStack {
      Spacer()
        configuration.label.foregroundColor(.white).font(.callout.weight(.semibold))
      Spacer()
    }
    .padding(.horizontal)
    .frame(height: 45)
    .background(Color.accentColor.cornerRadius(8))
    .scaleEffect(configuration.isPressed ? 0.97 : 1)
  }
}
