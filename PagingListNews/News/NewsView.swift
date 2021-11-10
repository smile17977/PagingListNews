//
//  NewsView.swift
//  PagingListNews
//
//  Created by Kirill Presnyakov on 10.11.2021.
//

import SwiftUI

struct NewsView: View {
    @ObservedObject var viewModel = NewsViewModel()
    var body: some View {
        CustomNavigationView(transition: .custom(.moveAndFade)) {
            VStack {
                Picker("", selection: $viewModel.selection) {
                    ForEach(viewModel.categories.indices, id: \.self) { index in
                        Text(viewModel.categories[index])
                            .tag(index)
                    }
                }
                .padding(.horizontal)
                .pickerStyle(.segmented)
                
                List {
                    ForEach(viewModel.news, id: \.self) { item in
                        PushNavigation(destination: NewsDetailsView(model: item)) {
                            VStack {
                                NewsItemView(model: item)
                                
                                
                                if viewModel.news.last == item {
                                    Divider()
                                    
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle())
                                        .onAppear { viewModel.loadNextPage() }
                                }
                            }
                        }
                    }
                }
                .listStyle(.plain)
                .addLoadingState(isLoading: $viewModel.isCategoryLoading)
                
                Spacer()
            }
        }
    }
}
