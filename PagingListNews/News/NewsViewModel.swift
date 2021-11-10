//
//  NewsViewModel.swift
//  PagingListNews
//
//  Created by Kirill Presnyakov on 10.11.2021.
//

import Foundation
import Networking
import Combine

final class NewsViewModel: ObservableObject {
    @Published var news = [Article]()
    @Published var categories: [String] = ["Tesla", "Ford"]
    @Published var startDate: Date = Date().advanced(by: -3600 * 24 * 7)
    
    @Published var page: Int = 1
    @Published var isPageLoading: Bool = false
    @Published var isCategoryLoading: Bool = false
    
    @Published var selection: Int = 0
    
    private var disposables = Set<AnyCancellable>()
    
    // MARK: Init
    
    init() {
        bind()
    }
    
    // MARK: Bind
    
    func bind() {
        $selection
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] selection in
                loadAnotherCategory()
            }
            .store(in: &disposables)
    }
    
    // MARK: Actions
    
    func loadNextPage() {
        guard !isPageLoading else { return }
        page += 1
        
        loadNews(completion: { [weak self] news in self?.updateNews(news) })
    }
    
    // MARK: Private
    
    private func loadNews(completion: @escaping ([Article]) -> Void) {
        isPageLoading = true
        
        ArticlesAPI
            .everythingGet(
                q: categories[selection],
                from: "\(startDate)",
                sortBy: "publishedAt",
                language: "ru",
                apiKey: "2ccd3241ea7d46578c96d5643dc188af",
                page: page) { data, _ in
                    completion(data?.articles ?? [])
                }
    }
    
    private func loadAnotherCategory() {
        guard !isPageLoading,
              !isCategoryLoading
        else {
            return
        }
        page = 1
        
        isCategoryLoading = true
        
        loadNews(completion: { [weak self] news in self?.refreshNews(news) })
    }
    
    private func updateNews(_ models: [Article]) {
        news.append(contentsOf: models)
        isPageLoading = false
    }
    
    private func refreshNews(_ models: [Article]) {
        news = models
        isPageLoading = false
        isCategoryLoading = false
    }
}
