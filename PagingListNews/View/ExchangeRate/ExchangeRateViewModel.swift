//
//  ExchangeRateViewModel.swift
//  PagingListNews
//
//  Created by KirillPresnyakov on 17.01.2022.
//

import Foundation
import Combine

final class ExchangeRateViewModel: ObservableObject {
    @Injected var interactor: ExchangeRateInteractor?
    
    @Published var tickers: [Ticker]?
    
    private var disposables = Set<AnyCancellable>()
    
    init() {}
    
    func onAppear() {
        getTickers()
    }
    
    func getExchangeRate(for cryptocurrency: String) {
        interactor?
             .getExchangeRate(for: cryptocurrency)
             .sink { completion in
                 if case let .failure(error) = completion {
                     print(error)
                 }
             } receiveValue: { [weak self] model in
                 guard let tickers = self?.tickers else { return }
                 if !tickers.contains(where: { $0.base == model.ticker.base && model.ticker.target == $0.target }) {
                     self?.tickers?.append(model.ticker)
                 }
             }
             .store(in: &disposables)
    }
    
    func getTickers() {
        interactor?
            .getTickers()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case let .failure(error) = completion {
                    print(error)
                }
                
            } receiveValue: { [weak self] tickers in
                self?.tickers = tickers
            }
            .store(in: &disposables)
    }
    
    func deleteAll() {
        interactor?
            .deleteAllTickers()
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { _ in
                self.getTickers()
            })
            .store(in: &disposables)
    }
}
