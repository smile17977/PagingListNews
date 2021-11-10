//
//  AsyncImage.swift
//  PagingListNews
//
//  Created by Kirill Presnyakov on 10.11.2021.
//

import SwiftUI

struct AsyncImage: View {
    @ObservedObject private var viewModel: AsyncImageViewModel
    
    private let defaultImage = UIImage(systemName: "theatermasks")
    
    init(url: String) {
        viewModel = AsyncImageViewModel(url: url)
    }
    
    var body: some View {
        content
    }
    
    @ViewBuilder
    private var content: some View {
        Image(uiImage: viewModel.image ?? defaultImage!)
            .resizable()
    }
}
