//
//  ExchangeRateResponse.swift
//  PagingListNews
//
//  Created by KirillPresnyakov on 17.01.2022.
//

import Foundation

struct ExchangeRateResponse: Decodable {
    let ticker: Ticker
    let timestamp: Int // Update time in Unix timestamp format
    let success: Bool // True or false
    let error: String // Error description
}

struct Ticker: Decodable {
    let base: String // Base currency code
    let target: String // Target currency code
    let price: String // Volume-weighted price
    let volume: String // Total trade volume for the last 24 hours
    let change: String // Past hour price change
}

extension Ticker: Identifiable {
    var id: String { UUID().uuidString }
}
