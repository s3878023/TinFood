//
//  SearchBarView.swift
//  TinFoodTest
//
//  Created by Donnie Tran on 9/14/23.
//

import Foundation
import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String

    var body: some View {
        ZStack(alignment: .leading) {
            TextField("Search", text: $searchText)
                .padding(.horizontal, 35)
                .padding(.vertical, 5)
                .background(Color.white)
                .cornerRadius(10)
                .padding(.horizontal, 16)
                .font(.system(size: 20))
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                .padding(.leading, 8)
                .padding(.horizontal, 17)
        }
        .padding(.bottom, 10)
    }
}
