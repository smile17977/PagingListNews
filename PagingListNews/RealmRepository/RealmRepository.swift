//
//  RealmRepository.swift
//  PagingListNews
//
//  Created by Kirill Presnyakov on 19.01.2022.
//

import Foundation
import RealmSwift

final class RealmRepository {
    private var instance: Realm!
    
    init() {
        setupRealm()
    }
    
    func deleteAll() {
        DispatchQueue.main.async {
            do {
                try self.instance!.write {
                    self.instance?.deleteAll()
                }
            } catch {
                print("Error - \(error)")
            }
        }
    }
    
    func getAllTickers() -> [Ticker] {
        guard let result = instance?.objects(RealmTicker.self) else { print("EMPTY"); return [] }
        
        return result.map {
            Ticker.init(
                base: $0.base,
                target: $0.target,
                price: $0.price,
                volume: $0.volume,
                change: $0.change
            )
        }
    }
    
    func add(ticker: Ticker) {
        let tickers = getAllTickers()
        
        guard !tickers.contains(where: { $0.base == ticker.base && ticker.target == $0.target }) else { return }
        
        let newTicker: RealmTicker = .init()
        
        newTicker.id = ticker.id
        newTicker.base = ticker.base
        newTicker.price = ticker.price
        newTicker.target = ticker.target
        newTicker.volume = ticker.volume
        newTicker.change = ticker.change
        
        DispatchQueue.main.async {
            do {
                try self.instance!.write {
                    self.instance!.add(newTicker)
                }
            } catch {
                print("Error - \(error)")
            }
        }
    }
    
    private func setupRealm() {
        let realmURL = try! FileManager.default
            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent("Realm")
        
        var configuration = Realm.Configuration()
        configuration.fileURL = realmURL
        
        instance = try! Realm(configuration: configuration, queue: .main)
    }
}
