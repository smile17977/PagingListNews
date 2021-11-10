//
//  Screen.swift
//  PagingListNews
//
//  Created by Kirill Presnyakov on 10.11.2021.
//

import SwiftUI

struct Screen {
    let nextScreen: AnyView
    
}

extension Screen: Identifiable {
    var id: String {
        UUID().uuidString
    }
}

extension Screen: Equatable {
    static func == (lhs: Screen, rhs: Screen) -> Bool {
        lhs.id == rhs.id
    }
}
