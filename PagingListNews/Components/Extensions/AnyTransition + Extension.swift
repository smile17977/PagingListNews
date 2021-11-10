//
//  Animation.swift
//  PagingListNews
//
//  Created by Kirill Presnyakov on 10.11.2021.
//

import SwiftUI

extension AnyTransition {
    static var moveAndFade: AnyTransition {
        let insertion = AnyTransition
            .move(edge: .leading)
            .combined(with: .opacity)
        let removal = AnyTransition
            .scale
            .combined(with: .opacity)
        return .asymmetric(insertion: insertion, removal: removal)
    }
}
