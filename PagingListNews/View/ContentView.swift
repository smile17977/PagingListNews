//
//  ContentView.swift
//  PagingListNews
//
//  Created by KirillPresnyakov on 09.11.2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NewsView()
                .tabItem {
                    Image(systemName: "newspaper")
                }
            
            ExchangeRateView()
                .tabItem {
                    Image(systemName: "dollarsign.square.fill")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
