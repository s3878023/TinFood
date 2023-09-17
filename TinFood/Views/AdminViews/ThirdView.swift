//
//  ThirdView.swift
//  TinFoodTest
//
//  Created by Donnie Tran on 9/14/23.
//

import Foundation
import SwiftUI

struct ThirdView: View {
    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
        VStack {
            SearchBarView(searchText: $viewModel.searchText)

            ScrollView {
                VStack {
                    ForEach(viewModel.filteredUsers, id: \.id) { user in
                        AllUserRowView(user: user, viewModel: viewModel)
                            .foregroundColor(.black)
                            .padding(.vertical, 16)
                            .padding(.horizontal, 16)
                    }
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 1)
                }
                .background(Color.clear)
                .padding(.bottom)
            }
        }
    }
}
