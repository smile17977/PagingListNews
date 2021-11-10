//
//  NewsItemView.swift
//  PagingListNews
//
//  Created by Kirill Presnyakov on 10.11.2021.
//

import SwiftUI
import Networking

struct NewsItemView: View {
    let model: Article
    
    var body: some View {
        HStack {
            model.urlToImage.map {
                AsyncImage(url: $0)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 100)
            }
            
            model.title.map {
                Text($0)
                    .font(.footnote)
                    .foregroundColor(.primary)
            }
        }
    }
}
