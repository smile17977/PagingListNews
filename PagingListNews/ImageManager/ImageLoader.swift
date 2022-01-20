//
//  ImageLoader.swift
//  PagingListNews
//
//  Created by Kirill Presnyakov on 10.11.2021.
//

import Combine
import SwiftUI

final class ImageLoader {
    static let shared = ImageLoader()
    
    private let imageCache = ImageCache.shared
    
    private init() {}
    
    func loadImage(from url: URL) -> AnyPublisher<UIImage?, Error> {
        let request = URLRequest(url: url)
        
        if let image = imageCache.getImage(for: request) {
            return Future<UIImage?, Never> { future in
                future(.success(image))
            }
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
        } else {
            return URLSession.shared.dataTaskPublisher(for: request)
                .map { (data, response) -> UIImage? in
                    self.imageCache.setImage(for: response, data: data, request: request)
                    return UIImage(data: data)
                }
                .mapError { $0 }
                .print("Image loading \(url):")
                .subscribe(on: DispatchQueue.global())
                .eraseToAnyPublisher()
        } 
    }
}
