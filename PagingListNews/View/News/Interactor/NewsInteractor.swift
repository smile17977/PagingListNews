//
//  NewsInteractor.swift
//  PagingListNews
//
//  Created by KirillPresnyakov on 25.11.2021.
//

import Foundation
import Networking

final class NewsInteractor {
    func fetchNews(
        category: String,
        startDate: Date,
        page: Int,
        completion: @escaping ([Article]) -> Void
    ) {
        ArticlesAPI
            .everythingGet(
                q: category,
                from: "\(startDate)",
                sortBy: "publishedAt",
                language: "ru",
                apiKey: "2ccd3241ea7d46578c96d5643dc188af",
                page: page) { data, _ in
                    completion(data?.articles ?? [])
                }
    }
}
