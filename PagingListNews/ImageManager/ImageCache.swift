//
//  ImageCache.swift
//  PagingListNews
//
//  Created by 18898505 on 17.01.2022.
//

import Foundation
import UIKit

final class ImageCache {
    static let shared = ImageCache()
    
    private let cache = URLCache.shared
    
    private init() {}
    
    func setImage(for response: URLResponse, data: Data, request: URLRequest) {
        let cachedData = CachedURLResponse(response: response, data: data)
        cache.storeCachedResponse(cachedData, for: request)
    }
    
    func getImage(for request: URLRequest) -> UIImage? {
        guard
            let cached = cache.cachedResponse(for: request),
            let image = UIImage(data: cached.data)
        else {
            return nil
        }
        
        return image
    }
}
