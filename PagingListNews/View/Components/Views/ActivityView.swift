//
//  ActivityView.swift
//  PagingListNews
//
//  Created by Kirill Presnyakov on 10.11.2021.
//

import SwiftUI

struct ActivityView: View {
    @Binding var isLoading: Bool
    
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle())
            .padding(50)
            .background(Color.gray.opacity(0.5))
            .cornerRadius(10)
    }
}
