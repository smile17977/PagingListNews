//
//  LoadingStateModifier.swift
//  PagingListNews
//
//  Created by Kirill Presnyakov on 10.11.2021.
//

import SwiftUI

struct LoadingStateModifier: ViewModifier {
    @Binding var isLoading: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            if !isLoading {
                content
            }
            
            if isLoading {
                ActivityView(isLoading: $isLoading)
            }
        }
    }
}

extension View {
    func addLoadingState(isLoading: Binding<Bool>) -> some View {
        self.modifier(LoadingStateModifier(isLoading: isLoading))
    }
}
