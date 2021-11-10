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
    
    func loadImage(from url: URL) -> AnyPublisher<UIImage?, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map { (data, response) -> UIImage? in return UIImage(data: data) }
            .mapError { $0 }
            .print("Image loading \(url):")
            .subscribe(on: DispatchQueue.global())
            .eraseToAnyPublisher()
    }
}
