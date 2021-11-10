//
//  ScreenStack.swift
//  PagingListNews
//
//  Created by Kirill Presnyakov on 10.11.2021.
//

struct ScreenStack {
    private var screens: [Screen] = .init()
    
    func topScreen() -> Screen? {
        screens.last
    }
    
    mutating func push(_ s: Screen) {
        screens.append(s)
    }
    
    mutating func popToPrevious() {
        _ = screens.popLast()
    }
    
    mutating func popToRoot() {
        screens.removeAll()
    }
}
