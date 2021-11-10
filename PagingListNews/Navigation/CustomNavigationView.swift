//
//  CustomNavigationView.swift
//  PagingListNews
//
//  Created by Kirill Presnyakov on 10.11.2021.
//

import SwiftUI

struct CustomNavigationView<Content>: View where Content: View {
    @ObservedObject private var viewModel: NavigationViewModel
    
    private let transition: (push: AnyTransition, pop: AnyTransition)
    private let content: Content
    
    init(transition: NavigationTransition, easing: Animation = .easeOut, @ViewBuilder content: @escaping () -> Content) {
        viewModel = NavigationViewModel(easing: easing)
        self.content = content()
        
        switch transition {
        case let .custom(transition):
            self.transition = (transition, transition)
        case .none:
            self.transition = (.identity, .identity)
        }
    }
    
    var body: some View {
        ZStack {
            if viewModel.isRoot {
                content
                    .environmentObject(viewModel)
                    .transition(transitionView)
            } else {
                viewModel
                    .currentStack?
                    .nextScreen
                    .environmentObject(viewModel)
                    .transition(transitionView)
            }
        }
    }
    
    private var transitionView: AnyTransition {
        switch viewModel.navigationType {
        case .push:
            return transition.push
        case .pop:
            return transition.pop
        }
    }
}
