//
//  NewsDetailsView.swift
//  PagingListNews
//
//  Created by Kirill Presnyakov on 10.11.2021.
//

import SwiftUI
import Networking

struct NewsDetailsView: View {
    @State private var text: String
    
    let model: Article
    
    init(model: Article) {
        self.model = model
        
        text = model.description ?? ""
    }
    
    var body: some View {
        VStack {
            PopNavigation(destination: .root) {
                HStack {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Назад")
                    }
                    .padding(5)
                    .background(Color.blue)
                    .foregroundColor(.primary)
                    .cornerRadius(10)
                    
                    Spacer()
                }
                .padding()
            }
            
            ScrollView {
                VStack {
                    model.title.map {
                        Text($0)
                            .font(.title)
                            .padding(.vertical)
                    }
                    
                    model.urlToImage.map {
                        AsyncImage(url: $0)
                            .aspectRatio(contentMode: .fill)
                    }
                    
                    
                    Text(text)
                        .font(.caption)
                        .padding(.horizontal)
                    
                    button
                        .padding(.top)
                }
                .onAppear { print(model) }
                .foregroundColor(.primary)
            }
        }
    }
    
    private var button: some View {
        PushNavigation(destination: EditNewsView(text: $text)) {
            Text("Отредактировать новость")
                .padding()
                .foregroundColor(.primary)
                .frame(width: UIScreen.main.bounds.width - 20)
                .background(Color.blue)
                .cornerRadius(10)
        }
    }
}
