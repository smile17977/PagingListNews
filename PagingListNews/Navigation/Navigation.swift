//
//  Navigation.swift
//  PagingListNews
//
//  Created by Kirill Presnyakov on 10.11.2021.
//

import Foundation
import SwiftUI

struct PushNavigation<Label, Destination>: View where Label: View, Destination: View {
    @EnvironmentObject private var vieModel: NavigationViewModel
    
    private let destination: Destination
    private let label: Label
    
    init(destination: Destination, @ViewBuilder label: @escaping () -> Label) {
        self.destination = destination
        self.label = label()
    }
    
    var body: some View {
        label
            .onTapGesture {
                vieModel.push(destination)
            }
    }
}

struct PopNavigation<Label>: View where Label: View {
    @EnvironmentObject private var vieModel: NavigationViewModel
    
    private let label: Label
    private let destination: PopDestination
    
    init(destination: PopDestination, @ViewBuilder label: @escaping () -> Label) {
        self.destination = destination
        self.label = label()
    }
    
    var body: some View {
        label
            .onTapGesture {
                vieModel.pop(to: destination)
            }
    }
}
