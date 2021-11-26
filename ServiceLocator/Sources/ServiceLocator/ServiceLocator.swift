//
//  ServiceLocator.swift
//
//
//  Created by Kirill Presnyakov on 25.11.2021.

import Foundation

public final class ServiceLocator: NSObject {
    private var containerServices = [String: AnyObject]()
    
    public override init() {}
    
    public func addService<T:AnyObject>(service: T) {
        let key = "\(T.self)"
        if containerServices[key] == nil {
            containerServices[key] = service
        }
    }
    
    public func getService<T:AnyObject>(type: T.Type)-> T? {
        let key = "\(T.self)"
        return containerServices[key] as? T
    }
}
