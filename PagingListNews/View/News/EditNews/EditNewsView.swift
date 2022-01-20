//
//  EditNewsView.swift
//  PagingListNews
//
//  Created by Kirill Presnyakov on 10.11.2021.
//

import SwiftUI

struct EditNewsView: View {
    @Binding var text: String
    
    init(text: Binding<String>) {
        self._text = text
        
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        VStack {
            PopNavigation(destination: .previous) {
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
            
            TextEditor(text: $text)
                .font(.title2)
                .foregroundColor(.primary)
                .background(Color.gray.opacity(0.5))
                .cornerRadius(10)
                .padding()
        }
    }
}
