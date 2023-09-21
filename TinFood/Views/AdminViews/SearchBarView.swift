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
                .foregroundColor(Color("text"))
                .background(Color("row"))
                .cornerRadius(10)
                .padding(.horizontal, 16)
                .font(.system(size: 20))
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color("text"))
                .padding(.leading, 8)
                .padding(.horizontal, 17)
        }
        .padding(.bottom, 10)
    }
}
