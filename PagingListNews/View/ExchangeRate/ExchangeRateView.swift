//
//  ExchangeRate.swift
//  PagingListNews
//
//  Created by KirillPresnyakov on 17.01.2022.
//

import SwiftUI

struct ExchangeRateView: View {
    @ObservedObject var viewModel = ExchangeRateViewModel()
    
    @State private var text: String = ""
    
    private var examples: [String] = ["AAVE-ETH", "AION-ETH", "1INCH-BUSD", "ADA-BUSD", "ADA-BRL", "ADA-RUB", "BTC-USDT", "CAKE-USDT"]
    
    var body: some View {
        VStack {
            HStack {
                Text("Cryptocurrencies exchange rates")
                    .foregroundColor(.primary)
                    .font(.title)
                    .padding(.bottom, 30)
                
                Spacer()
            }
            
            
            TextField(
                "enter cryptocurrency",
                text: $text,
                onCommit: {
                    viewModel.getExchangeRate(for: text)
                })
                .padding(.top, 20)
                .padding(.bottom, 10)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            exampleList
                .opacity(0.5)
                .padding(.vertical, 5)
            
            Divider()
            
            HStack {
                Spacer()
                
                Button(action: viewModel.deleteAll) {
                    Text("clear all")
                }
            }
            
            viewModel.tickers.map { tickers in
                ScrollView {
                    ForEach(tickers) { ticker in
                        TickerView(model: ticker)
                    }
                }
            }
            
        }
        .padding(.horizontal)
        .onAppear(perform: viewModel.onAppear)
    }
    
    @ViewBuilder
    private var exampleList: some View {
        VStack(alignment: .leading) {
            Text("Examples")
                .foregroundColor(.primary)
                .font(.body)
            
            LazyVGrid(columns: columns, spacing: 5) {
                ForEach(examples, id: \.self) { example in
                    Button(action: { viewModel.getExchangeRate(for: example) }) {
                        Text(example)
                            .foregroundColor(.primary)
                            .font(.caption2)
                            .padding(3)
                            .border(Color.primary, width: 1)
                    }
                }
            }
        }
    }
    
    private var columns: [GridItem] {
        [
            .init(.flexible()),
            .init(.flexible()),
            .init(.flexible()),
            .init(.flexible())
        ]
    }
}

struct TickerView: View {
    let model: Ticker
    
    var body: some View {
        VStack {
            HStack {
                HStack {
                    Text(model.base)
                    Text(" - ")
                    Text(model.target)
                }
                .font(.body)
                
                Spacer()
                
                Text(model.price)
                    .font(.caption2)
            }
            .foregroundColor(.primary)
            
            Divider()
                .padding(.vertical, 10)
        }
    }
}
