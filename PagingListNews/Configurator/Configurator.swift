//
//  Configurator.swift
//  PagingListNews
//
//  Created by 18898505 on 25.11.2021.
//

import Foundation
import ServiceLocator

final class Configurator {
    static let shared = Configurator()
    let serviceLocator = ServiceLocator()
    
    func setup() {
        registerServices()
    }
    
   private func registerServices() {
       serviceLocator.addService(service: NewsInteractor())
       serviceLocator.addService(service: RealmRepository())
       serviceLocator.addService(service: ExchangeRateInteractor())
    }
}
