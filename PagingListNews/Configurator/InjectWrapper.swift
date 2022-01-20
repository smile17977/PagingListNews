//
//  InjectWrapper.swift
//  
//
//  Created by Kirill Presnyakov on 25.11.2021.
//

import Foundation
import ServiceLocator

@propertyWrapper
struct Injected<Service:AnyObject> {
    private var service: Service?
    private weak var serviceLocator = Configurator.shared.serviceLocator
    

    public var wrappedValue: Service? {
        mutating get {
            if service == nil {
                service = serviceLocator?.getService(type: Service.self)
            }
            return service
        }
        mutating set {
            service = newValue
        }
    }
    
    public var projectedValue: Injected<Service> {
        mutating set {self = newValue}
        get {return self}
    }
}
