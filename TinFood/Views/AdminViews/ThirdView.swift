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
    let backgroundColor = Color("background")

    var body: some View {
        VStack {
            SearchBarView(searchText: $viewModel.searchText)

            ScrollView {
                VStack {
                    NavigationView {
                        List{
                            ForEach(viewModel.filteredUsers, id: \.id) { user in
                                AllUserRowView(user: user, viewModel: viewModel)
                                    .foregroundColor(.black)
                                    .padding(.vertical, 18)
                                    .cornerRadius(10)
                                    .listRowSeparator(.hidden)
                                    .listRowBackground(
                                        RoundedRectangle(cornerRadius: 10) // Add corner radius to each list item
                                            .fill(.white)
                                            .frame(height: 60) // Adjust the height of the rounded rectangle as needed
                                    )
                            }
                            .onDelete(perform: removeData)
                        }
                        .background(backgroundColor)
                        .listStyle(PlainListStyle())
                    }
                }
                .background(backgroundColor)
                .padding(.bottom)
            }
            .padding(.horizontal)
        }
        .background(backgroundColor)
    }
    func removeData(at offsets: IndexSet){
        for index in offsets{
            if let documentID = viewModel.users[index].documentID{
                viewModel.removeUserData(documentID: documentID)
            }
        }
    }

}
