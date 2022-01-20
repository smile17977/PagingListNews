//
//  ExchangeRateInteractor.swift
//  PagingListNews
//
//  Created by KirillPresnyakov on 17.01.2022.
//

import Foundation
import Combine

final class ExchangeRateInteractor {
    @Injected private var repository: RealmRepository?
    
    func getExchangeRate(for cryptoCurrency: String) -> AnyPublisher<ExchangeRateResponse, Error> {
        let url = URL(string: "https://api.cryptonator.com/api/ticker/\(cryptoCurrency)")!
        
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .map({ data, response in
                return data
            })
            .decode(type: ExchangeRateResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .map {
                self.repository?.add(ticker: $0.ticker)
                return $0
            }
            .eraseToAnyPublisher()
    }
    
    func getTickers() -> AnyPublisher<[Ticker], Error> {
        Future<[Ticker], Error> { future in
            if let tickers = self.repository?.getAllTickers() {
                print("1111")
                future(.success(tickers))
            } else {
                print("2222")
                future(.failure(ExchangeRateInteractorError.getTickers))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func deleteAllTickers() -> AnyPublisher<Void, Never> {
        Future<Void, Never> { future in
            self.repository?.deleteAll()
            future(.success(()))
        }
        .eraseToAnyPublisher()
    }
}

extension ExchangeRateInteractor {
    enum ExchangeRateInteractorError: Error {
        case getTickers
    }
}
