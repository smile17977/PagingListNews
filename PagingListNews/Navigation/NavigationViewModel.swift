//
//  NavigationViewModel.swift
//  PagingListNews
//
//  Created by Kirill Presnyakov on 10.11.2021.
//

import SwiftUI

final class NavigationViewModel: ObservableObject {
    @Published var currentStack: Screen?
    
    var navigationType: NavigationType = .push
    private let easing: Animation
    
    var isRoot: Bool {
        currentStack == nil
    }
    
    private var screenStack = ScreenStack() {
        didSet {
            currentStack = screenStack.topScreen()
        }
    }
    
    init(easing: Animation) {
        self.easing = easing
    }
    
    func push<S: View>(_ screenView: S) {
        let screen = Screen(nextScreen: AnyView(screenView))
        
        withAnimation(easing) {
            navigationType = .push
            screenStack.push(screen)
        }
    }
    
    func pop(to dest: PopDestination) {
        withAnimation(easing) {
            navigationType = .pop
            
            switch dest {
            case .previous:
                screenStack.popToPrevious()
            case .root:
                screenStack.popToRoot()
            }
        }
    }
}

